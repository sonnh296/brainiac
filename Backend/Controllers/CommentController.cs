using Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : Controller
    {
        private readonly PRN231_V2Context _context;
        public CommentController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetCommentsOfCourseAsync(int courseId)
        {
            var comments = _context.Comments.Where(x => x.CourseId == courseId)
                .Include(c => c.User);
            if(comments == null)
            {
                return NoContent();
            }
            return Ok(comments);
        }
    }
}
