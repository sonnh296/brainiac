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
            double? avg = ratings.Average(x => x.Point);
            int totalReview = ratings.Count();
            int count5 = ratings.Count(x => x.Point == 5);
            int count4 = ratings.Count(x => x.Point == 4);
            int count3 = ratings.Count(x => x.Point == 3);
            int count2 = ratings.Count(x => x.Point == 2);
            int count1 = ratings.Count(x => x.Point == 1);
            var obj = new
            {
                Avg = avg,
                TotalReview = totalReview,
                Count5 = count5,
                Count4 = count4,
                Count3 = count3,
                Count2 = count2,
                Count1 = count1
            };
            return Ok(obj);
        }
    }
}
