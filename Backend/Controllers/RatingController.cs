using Backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RatingController : Controller
    {
        private readonly PRN231_V2Context _context;
        public RatingController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetRatingOfCourseAsync(int courseId)
        {
            var ratings = _context.Ratings.Where(x => x.CourseId == courseId);
            if(ratings == null)
            {
                return NoContent();
            }
            return Ok(ratings);
        }
    }
}
