using AutoMapper;
using Backend.CustomizedExceptions;
using Backend.DTOs.Course;
using Backend.DTOs.Resource;
using Backend.Models;
using Backend.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TeacherController : ControllerBase
    {
        private readonly ITeacherService service;
        private readonly IMapper mapper;

        public TeacherController(ITeacherService _service, IMapper map)
        {
            service = _service;
            mapper = map;
        }

        // get course list by a teacher
        //[HttpGet("GetAllCourses/{teacherid}")]
        [HttpGet("GetAllCourses/")]
        public async Task<ActionResult<List<CourseDTO>>> GetCourseListFromTeacherAsync()
        {
            var teacherId = 2;
            var courses = await service.GetCourseListByTeacherAsync(teacherId);
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

        // get a single course by a teacher
        [HttpGet("GetSingleCourse")]
        public async Task<ActionResult<CourseDTO>> GetSinglgeCourseByIdAsync([FromQuery] int teacherId, [FromQuery] int courseId)
        {
            var course = await service.GetSingleCourseByIdAsync(teacherId, courseId);
            var dto = mapper.Map<CourseDTO>(course);
            return Ok(dto);
        }

        // add a new course
        [HttpPost("addCourse/{teacherId}")]
        public async Task<ActionResult<CourseDTO>> CreateNewCourseDraft(int teacherId, CourseCreateDTO course)
        {
            try
            {
                var createdCourse = await service.CreateCourseDraft(teacherId, course);
                return Ok(course);
            }
            catch (ArgumentNullException)
            {
                return BadRequest("Course name cannot be empty");
            }
            catch (RepeatedExeption)
            {
                return BadRequest("Course name has already existed");
            }
        }

        // edit a course info
        [HttpPut("editCourse/{courseId}")]
        public async Task<ActionResult<CourseDTO>> EditCourse(CourseDTO courseUpdate, int courseId)
        {
            try
            {
                await service.UpdateCourseAsync(courseId, courseUpdate);
                return Ok(courseUpdate);
            }
            catch(Exception)
            {
                return BadRequest("Course name has already existed");
            }
        }

        // add a new resource to a course
        [HttpPost("Resource/AddResource/{courseId}")]
        public async Task<ActionResult<ResourceDTO>> CreateResourceDraft(int courseId, ResourceCreateDTO resource)
        {
            try
            {
                var res = await service.CreateResource(courseId, resource);
                return Ok(resource);
            }
            catch (ArgumentNullException)
            {
                return BadRequest("Resource name cannot be empty");
            }
            catch (RepeatedExeption)
            {
                return BadRequest("Resource name has already existed");
            }
        }
    }
}
