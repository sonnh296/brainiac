using Backend.Models;
using Backend.Services;
using Backend.Services.Implement;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : Controller
    {
        private readonly PRN231_V2Context _context;
        public CourseController(PRN231_V2Context context)
        {
            _context = context;
        }

        // GET: api/Course/CourseDetail/5
        [HttpGet("CourseDetail/{id}")]
        public async Task<IActionResult> GetCourseDetailAsync(int id)
        {
            var course = _context.Courses.FirstOrDefault(x => x.CourseId == id);
            if(course == null)
            {
                return NotFound();
            }
            var test = _context.UserCourses.Where(uc => uc.CourseId==id).ToList();
            var author = _context.UserCourses
                .Include(x => x.User)
                .FirstOrDefault(x => x.CourseId == id && x.IsStudent == false)?
                .User;
            var listCategory = _context.CategoryCourses
                .Where(x => x.Course.CourseId == id).Select(x => x.Category);
            int countEnrolled = _context.UserCourses.Where(x => x.CourseId == id && x.IsStudent == true).Count();

            var obj = new
            {
                CourseId = course.CourseId,
                Name = course.CourseName,
                Description = course.Title,
                Lessons = course.Resources.Count(),
                Author = new {UserId = author.UserId, UserName = author.UserName},
                Categories = listCategory,
                Enrolled = countEnrolled
            };
            return Ok(obj);
        }

        // GET: api/Course/MyCourses/5
        //[HttpGet("MyCourses/{userId}")]
        //public async Task<IActionResult> GetCoursesOfUserAsync(int userId)
        //{
        //    var courses = await _courseService.GetCoursesOfUserAsync(userId);
        //    if(courses == null)
        //    {
        //        return NoContent();
        //    }
        //    return Ok(courses);
        //}
        [HttpGet("Related/{id}")]
        public async Task<IActionResult> GetRelatedCoursesAsync(int id)
        {
            var course = _context.Courses.FirstOrDefault(x => x.CourseId == id);
            if(course == null)
            {
                return NotFound();
            }
            var listCategory = _context.CategoryCourses
                .Where(x => x.Course.CourseId == id).Select(x => x.Category);
            var listCourse = _context.CategoryCourses
                .Where(x => listCategory.Any(c => c.CategoryId == x.CategoryId) && x.CourseId != id)
                .Select(x => x.Course);
            return Ok(listCourse);
        }
    }
}
