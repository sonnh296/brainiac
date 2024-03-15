using AutoMapper;
using Backend.DTOs;
using Backend.Services;
using Backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("a[controller]")]
    [ApiController]
    public class StudentController : ControllerBase
    {
        private readonly IStudentService service;
        private readonly IMapper mapper;

        public StudentController(IStudentService service, IMapper mapper)
        {
            this.service = service;
            this.mapper = mapper;
        }

        // get all courses that a student has enrolled
        [HttpGet("GetEnrolledCourses/{studentId}")]
        public async Task<ActionResult<List<CourseDTO>>> GetCoursesOfStudent(int studentId)
        {
            var courses = await service.GetCoursesOfStudentAsync(studentId);
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

    }
}
