using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Backend.Controllers.Admin
{
    [Route("Admin/[controller]")]
    [ApiController]

    public class ManageCourseController : ControllerBase
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<Course> _courseRepository;
        private readonly ITestRepository _testRepository;
        private readonly IResourceRepository _resourceRepository;

        public ManageCourseController(PRN231_V2Context context, ITestRepository testRepository, IResourceRepository resourceRepository)
        {
            _context = context;
            _courseRepository = new GenericRepository<Course>(_context);
            _testRepository = testRepository;
            _resourceRepository = resourceRepository;
           
        }

        [HttpGet("GetAllCourses")]
        public async Task<IActionResult> GetAllCourses(string? searchText)
        {
                var query = _context.Courses.Select(x => new
                {
                    x.CourseId,
                    x.CourseName,
                    x.Title,
                    x.Price,
                    x.Status
                });
                   if (!string.IsNullOrEmpty(searchText))
                   {
                       query = query.Where(x => x.CourseName.Contains(searchText) || x.Title.Contains(searchText) );
                   }
            var coursesWithUsers = await query.ToListAsync();
            if (coursesWithUsers != null && coursesWithUsers.Any())
            {
                return Ok(coursesWithUsers);
            }
            else
            {
                return NotFound("No courses found");
            }

        }
        [HttpGet("GetCourse/{id}")]
        public async Task<IActionResult> GetCourseById(int id)
        {
            var courseWithUsers = await _context.Courses
         .Where(c => c.CourseId == id)
         .Join(_context.UserCourses,
             course => course.CourseId,
             userCourse => userCourse.CourseId,
             (course, userCourse) => new { Course = course, UserCourse = userCourse })
         .Join(_context.Users,
             combined => combined.UserCourse.UserId,
             user => user.UserId,
             (combined, user) => new
             {
                 CourseId = combined.Course.CourseId,
                 CourseName = combined.Course.CourseName,
                 Title = combined.Course.Title,
                 Price = combined.Course.Price,
                 Status = combined.Course.Status,
                 UserId = user.UserId,
                 UserName = user.UserName,
                 Email = user.Email,
                 Role = user.Role
             })
         .FirstOrDefaultAsync();

            if (courseWithUsers != null)
            {
                return Ok(courseWithUsers);
            }
            else
            {
                return NotFound("Course not found");
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
        [HttpGet("GetResourcesByCourse/{courseId}")]
        public IActionResult GetResourcesByCourseId(int courseId)
        {
            try
            {
                List<Resource> resources = _resourceRepository.GetByResourceId(courseId);
                if (resources == null || resources.Count == 0)
                {
                    return NotFound("No tests found for the provided course ID");
                }
                return Ok(resources);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPut("UpdateCourseStatus/{id}")]
        public async Task<IActionResult> UpdateCourseStatus(int id, [FromBody] string status)
        {
            if (!IsValidStatus(status))
            {
                return BadRequest("Invalid status. Allowed values are: 1, 0, 'approved', 'rejected', 'draft'.");
            }

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