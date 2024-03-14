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
        [HttpGet("course/{teacherid}")]
        public async Task<ActionResult<List<CourseDTO>>> GetCourseListFromTeacherAsync(int teacherid)
        {
            var courses = await service.GetCourseListByTeacherAsync(teacherid);
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

        // get a single course by a teacher
        [HttpGet("GetCourse")]
        public async Task<ActionResult<CourseDTO>> GetSinglgeCourseByIdAsync([FromQuery] int teacherId, [FromQuery] int courseId)
        {
            var course = await service.GetSingleCourseByIdAsync(teacherId, courseId);
            var dto = mapper.Map<CourseDTO>(course);
            return Ok(dto);
        }

        // add a new course
        [HttpPost("course/add/{teacherId}")]
        public async Task<ActionResult<Course>> CreateNewCourseDraft(int teacherId, [FromBody] CourseDTO course)
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
    }
}
