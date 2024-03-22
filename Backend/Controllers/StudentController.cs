using AutoMapper;
using Backend.Services;
using Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Backend.DTOs.Course;
using Microsoft.AspNetCore.Authorization;
using System.Data;

namespace Backend.Controllers
{
    [Route("[controller]")]
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
		[Authorize(Roles = "Student, Admin")]
		[HttpGet("GetEnrolledCourses/{studentId}")]
        public async Task<ActionResult<List<CourseDTO>>> GetCoursesOfStudent(int studentId)
        {
            var courses = await service.GetCoursesOfStudentAsync(studentId);
            var dtos = mapper.Map<List<CourseDTO>>(courses);
            return Ok(dtos);
        }

    }
}
