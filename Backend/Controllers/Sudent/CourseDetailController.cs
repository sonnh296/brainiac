using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers.Sudent
{
    [Route("Student/[controller]")]
    [ApiController]
    public class CourseDetailController : Controller
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<Course> _courseRepository;
        private readonly IGenericRepository<ReportedComment> _reportedCommentRepository;
        private readonly IGenericRepository<UserCourse> _userCourseRepository;
        public CourseDetailController(PRN231_V2Context context)
        {
            _context = context;
            _courseRepository = new GenericRepository<Course>(_context);
            _reportedCommentRepository = new GenericRepository<ReportedComment>(_context);
            _userCourseRepository = new GenericRepository<UserCourse>(_context);
        }

        // GET: /Student/CourseDetail/5
        [HttpGet("GetCourseDetail/{id}")]
        public async Task<IActionResult> GetCourseDetailById(int id)
        {
            Course course = await _courseRepository.GetByIdAsync(id);
            if(course != null)
            {
                //int lessonCount = course.Resources.Count;
                //User author = course.UserCourses.FirstOrDefault(c => c.IsStudent == true).User;
                //var categories = course.CategoryCourses.ToList();
                //int countEnrolled = course.UserCourses.Count - 1;
                //return Ok(new
                //{
                //    CourseId = course.CourseId,
                //    CourseName = course.CourseName,
                //    Title = course.Title,
                //    Price = course.Price,
                //    Lessons = lessonCount,
                //    Author = author,
                //    Categories = categories,
                //    Enrolled = countEnrolled
                //});
                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        
        //Get list related courses
        // GET: /Student/CourseDetail/5
        [HttpGet("GetRelatedCourse/{id}")]
        public async Task<ActionResult<IEnumerable<Course>>> GetRelatedCourses(int id)
        {
            Course course = await _courseRepository.GetByIdAsync(id);
            if(course != null)
            {
                var categoryIds = course.CategoryCourses.Select(c => c.CategoryId).ToList();

                var relatedCourses = await _courseRepository.GetAllAsync();
                relatedCourses = relatedCourses
                    .Where(c => c.CourseId != id && c.CategoryCourses.Any(cc => categoryIds.Contains(cc.CategoryId)))
                    .Take(5)
                    .ToList();

                return Ok(relatedCourses);
            }
            else
            {
                return NotFound();
            }
        }

        // POST: /Student/CourseDetail/ReportComment
        [HttpPost("ReportComment")]
        public async Task<IActionResult> ReportComment(ReportedComment reportedComment)
        {
            if(ModelState.IsValid)
            {
                _reportedCommentRepository.Add(reportedComment);
                await _reportedCommentRepository.SaveAsync();
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPost("EnrollCourse")]
        public async Task<IActionResult> EnrollCourse(UserCourse userCourse)
        {
            if(ModelState.IsValid)
            {
                _userCourseRepository.Add(userCourse);
                await _userCourseRepository.SaveAsync();
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }   
    }
}
