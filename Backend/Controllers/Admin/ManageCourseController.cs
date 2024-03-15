using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers.Admin
{
    [Route("Admin/[controller]")]
    [ApiController]

    public class ManageCourseController : ControllerBase
    {
        private readonly PRN231_V2Context _context;
      

        public ManageCourseController(PRN231_V2Context context)
        {
            _context = context;
           
        }
        [HttpGet("GetAllCourses")]
        public async Task<IActionResult> GetAllCourses()
        {
            var allCourses = await _context.Courses.ToListAsync();
            if (allCourses != null && allCourses.Any()) {
                var result = allCourses.Select(x => new
                {
                    x.CourseId,
                    x.CourseName,
                    x.Title,
                    x.Price,
                    x.Status
                });
                return Ok(result);
            }else
            {
                return NotFound("No users found");
            }
            
        }
    }
}
