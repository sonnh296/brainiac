using AutoMapper;
using Backend.CustomizedExceptions;
using Backend.DTOs;
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
        [HttpPost("course/addCourse/{teacherId}")]
        public async Task<ActionResult<CourseDTO>> CreateNewCourseDraft(int teacherId, [FromBody] CourseDTO course)
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

        // add a new resource to a course
        [HttpPost("Resource/AddResource")]
        public async Task<ActionResult<ResourceDTO>> CreateResourceDraft(ResourceDTO resource)
        {

            return Ok();
        }
    }
}
