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
            if (allCourses != null && allCourses.Any())
            {
                var result = allCourses.Select(x => new
                {
                    x.CourseId,
                    x.CourseName,
                    x.Title,
                    x.Price,
                    x.Status
                });
                return Ok(result);
            }
            else
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
        // PUT: Admin/ManageCourse/UpdateCourseStatus/{id}
        [HttpPut("UpdateCourseStatus/{id}")]
        public async Task<IActionResult> UpdateCourseStatus(int id, [FromBody] string status)
        {
            //if (!IsValidStatus(status))
            //{
            //    return BadRequest("Invalid status. Allowed values are: 1, 0, 'approved', 'rejected', 'draft'.");
            //}

            if (ModelState.IsValid)
            {
                // Check if the course with the given ID exists
                Course existingCourse = await _courseRepository.GetByIdAsync(id);

                if (existingCourse == null)
                {
                    return NotFound("Course not found");
                }

                // Update the course's status
                existingCourse.Status = status;

                try
                {
                    // Save changes to the database
                    await _context.SaveChangesAsync();
                    return Ok(existingCourse);
                }
                catch (DbUpdateException ex)
                {
                    // Handle exceptions if any
                    return StatusCode(500, $"Failed to update course status: {ex.Message}");
                }
            }
            else
            {
                return BadRequest(ModelState);
            }
        }

        private bool IsValidStatus(string status)
        {
            List<string> allowedStatuses = new List<string> { "1", "0", "pending", "draft" };// 0 : rejected; 1: approved
            return allowedStatuses.Contains(status);
        }
    }
}