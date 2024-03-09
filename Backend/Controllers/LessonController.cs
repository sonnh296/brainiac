using Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LessonController : Controller
    {
        private readonly PRN231_V2Context _context;
        public LessonController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetLessonsOfCourseAsync(int courseId)
        {
            //var lessons = _context.Resources.Where(x => x.CourseId == courseId)
            //    .Include(x => x.ResourceUsers)
            //    .Select(x => new {
            //        LessonId = x.ResourceId,
            //        Content = x.Content,
            //        Description = x.Description,
            //        Type = x.Type,
            //        Free = x.IsFree,
            //        OrdinalNumber = x.OrdinalNumber,
            //        IsComplete = x.ResourceUsers.Select(x => x.IsComplete)
            //    });
            var lessons = _context.Resources.Where(x => x.CourseId == courseId);
            if(lessons == null)
            {
                return NoContent();
            }
            return Ok(lessons);
        }
    }
}
