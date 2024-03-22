using AutoMapper;
using Backend.CustomizedExceptions;
using Backend.DTOs.Course;
using Backend.DTOs.Resource;
using Backend.Models;
using Backend.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TeacherController : BaseApiController
    {
        private readonly ITeacherService service;
        private readonly IMapper mapper;

        public TeacherController(ITeacherService _service, IMapper map)
        {
            service = _service;
            mapper = map;
        }

        // get course list by a teacher
        [Authorize(Roles = "Teacher, Student, Admin")]
        [HttpGet("GetAllCourses/{teacherid}")]
        public async Task<ActionResult<List<CourseDTO>>> GetCourseListFromTeacherAsync(int teacherid)
        {
            var courses = await service.GetCourseListByTeacherAsync(teacherid);
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

        // get a single course by a teacher
        [HttpGet("course/single/{teacherId}/{courseId}")]
        public async Task<ActionResult<CourseDTO>> GetSinglgeCourseByIdAsync(int teacherId, int courseId)
        {
            var course = await service.GetSingleCourseByIdAsync(teacherId, courseId);
            if (course == null)
            {
                return NotFound("No course available");
            }
            var dto = mapper.Map<CourseDTO>(course);
            return Ok(dto);
        }

        // add a new course
        [HttpPost("course/add/{teacherId}")]
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
        [HttpPut("course/edit/{teacherid}/{courseId}")]
        public async Task<ActionResult<CourseDTO>> EditCourse(CourseUpdateDTO courseUpdate, int courseId, int teacherid)
        {
            Course courseToUpdate = await service.GetSingleCourseByIdAsync(teacherid, courseId);
            if (courseToUpdate == null)
            {
                return NotFound();
            }
            Course course = await service.UpdateCourseAsync(courseId, courseUpdate);
            if (course == null)
            {
                return NotFound();
            }
            var dto = mapper.Map<CourseDTO>(course);
            return Ok(dto);
        }

        // delete a course(change status)
        [HttpPut("/course/delete/{teacherId}/{courseId}")]
        public async Task<ActionResult<CourseDTO>> DeleteCourse(int teacherId, int courseId)
        {
            var course = await service.DeleteCourseAsync(teacherId, courseId);
            if (course == null)
            {
                return BadRequest();
            }
            return Ok();
        }

        // get resource list from a course
        [HttpGet("course/resource/list/{courseId}")]
        public async Task<ActionResult<List<ResourceDisplayDTO>>> GetResourceFromACourse(int courseId)
        {
            var resources = await service.GetResourceListFromCourseAsync(courseId);
            var dtos = mapper.Map<List<ResourceDisplayDTO>>(resources);
            return Ok(dtos);
        }

        // add a new resource to a course
        [HttpPost("resource/add/{courseId}")]
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

        // edit a resource in a course(change status)
        [HttpPut("/resource/update/{resourceId}")]
        public async Task<ActionResult<ResourceDisplayDTO>> UpdateResourceInCourse(int resourceId, ResourceUpdateDTO resource)
        {
            var course = await service.UpdateResourceAsync(resourceId, resource);
            if (course == null)
            {
                return NotFound();
            }
            return Ok();
        }

        // search a course by name
        [HttpGet("course/search/{teacherId}/{keyword}")]
        public async Task<ActionResult<List<CourseDTO>>> SearchCourseByName(int teacherId, string keyword)
        {
            var courses = await service.SearchCourseByNameAsync(teacherId, keyword);
            if(courses == null)
            {
                return NotFound();
            }
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

        // add a test to course
        [HttpPost("test/add/{courseId}")]
        public async Task<ActionResult<List<Test>>> AddTestToCourse(int courseId, Test test)
        {
            return Ok();
        }
    }
}
