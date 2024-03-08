using Backend.Models;
using Backend.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class TeacherController : ControllerBase
    {
        private readonly ITeacherService service;

        public TeacherController(ITeacherService service)
        {
            this.service = service;
        }

        // get courses by a teacher
        [HttpGet("course/{teacherid}")]
        public async Task<ActionResult<List<Course>>> GetCourseListFromTeacherAsync(int teacherid)
        {
            var courses = await service.GetCourseListByTeacherAsync(teacherid);
            return Ok(courses);
        }

    }
}
