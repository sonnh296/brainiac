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
        private readonly IGenericRepository<Course> _courseRepository;
        private readonly ITestRepository _testRepository;

        public ManageCourseController(PRN231_V2Context context, ITestRepository testRepository)
        {
            _context = context;
            _courseRepository = new GenericRepository<Course>(_context);
            _testRepository = testRepository;
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
        [HttpGet("GetCourse/{id}")]
        public async Task<IActionResult> GetCourseById(int id)
        {
            Course course = await _courseRepository.GetByIdAsync(id);

            if (course != null)
            {
                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetTestsByCourse/{courseId}")]
        public IActionResult GetTestsByCourse(int courseId)
        {
            try
            {
                List<Test> tests = _testRepository.GetByCourseId(courseId);
                if (tests == null || tests.Count == 0)
                {
                    return NotFound("No tests found for the provided course ID");
                }
                return Ok(tests);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
