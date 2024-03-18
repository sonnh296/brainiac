using Backend.Models;
using Backend.Services;
using Backend.Services.Implement;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [Route("api/Order")]
    [ApiController]
    public class OrderDetailController : Controller
    {
        private readonly PRN231_V2Context _context;
        public OrderDetailController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpPost("Payment")]
        public async Task<IActionResult> PaymentAsync([FromBody] OrderDetail orderDetail)
        {
            try
            {
                orderDetail.Date = DateTime.Now;
                _context.OrderDetails.Add(orderDetail);
                _context.SaveChanges();

                decimal? moneyForTeacher = orderDetail.Total * 0.8m;
                decimal? moneyForAdmin = orderDetail.Total * 0.2m;
                var user = _context.Users.Find(orderDetail.UserId);
                if (orderDetail.CourseId != null)
                {
                    user.Balance -= orderDetail.Total;
                    var teacher = _context.UserCourses
                        .Include(u => u.User)
                        .FirstOrDefault(x => x.CourseId == orderDetail.CourseId && x.IsStudent == false)?
                        .User;
                    teacher.Balance += moneyForTeacher;
                    _context.Update(teacher);
                    var admin = _context.Users.FirstOrDefault(x => x.RoleId == 3);
                    admin.Balance += moneyForAdmin;
                    _context.Update(admin);
                }else
                {
                    user.Balance += orderDetail.Total;
                }
                _context.Update(user);
                _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception)
            {
                return BadRequest();
            }
        }

        [HttpGet("History/{userId}")]
        public async Task<IActionResult> GetHistoryAsync(int userId)
        {
            var orderDetails = _context.OrderDetails
                .Include(x => x.Course)
                .Where(x => x.UserId == userId)
                .Select(x => new
                {
                    OrderId = x.OrderId,
                    CourseId = x.CourseId,
                    Date = x.Date,
                    Total = x.Total,
                    CourseName = x.Course != null ? x.Course.CourseName : null
                })
                .OrderByDescending(x => x.Date);
            if (orderDetails == null)
            {
                return NoContent();
            }
            return Ok(orderDetails);
        }
    }
}
