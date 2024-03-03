using Backend.Models;
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
