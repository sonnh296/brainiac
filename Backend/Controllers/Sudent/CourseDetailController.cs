using Backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers.Sudent
{
    [Route("[Student]/[controller]")]
    [ApiController]
    public class CourseDetailController : Controller
    {
        private readonly PRN231_V2Context _context;
        public CourseDetailController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCourseDetailById(int id)
        {
            if(_context.Courses.Any(x => x.CourseId == id))
            {
                //var courseDetail = await _context.Courses
                    
                //return Ok(courseDetail);
            }
            return View();
        }
    }
}
