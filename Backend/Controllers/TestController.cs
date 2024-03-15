using Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : Controller
    {
        private readonly PRN231_V2Context _context;
        public TestController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetTestOfCourseAsync(int courseId)
        {
            var tests = _context.Tests.Where(x => x.CourseId == courseId)
                .OrderBy(x => x.TestId)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.TestName
                });
            if(tests == null)
            {
                return NoContent();
            }
            return Ok(tests);
        }

        [HttpGet("HistoryTest/{testId}")]
        public async Task<IActionResult> HistoryTestlAsync(int testId)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = -1;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;
                // or
                userID = Int32.Parse(identity.FindFirst("ID").Value);
            }
            var test = _context.UserTests
                .Include(x => x.Test)
                .Where(x => x.TestId == testId && x.UserId == userID)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.Test.TestName,
                    TimeDoTest = x.TotalTime,
                    Point = x.Point,
                    TestDate = x.TestDate
                })
                .OrderByDescending(x => x.TestDate);
            if(test == null)
            {
                return NotFound();
            }
            return Ok(test);
        }

        [HttpGet("TestDetail/{testId}")]
        public async Task<IActionResult> GetTestDetailAsync(int testId)
        {
            var test = _context.Tests
                .Include(x => x.Questions)
                .Where(x => x.TestId == testId)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.TestName,
                    Time = x.Time,
                    PercentPoint = x.PercentPoint,
                    NumberQuestion = x.Questions.Count()
                });
            if(test == null)
            {
                return NotFound();
            }
            return Ok(test);
        }
    }
}
