using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers.Sudent
{
    [Route("Student/[controller]")]
    [ApiController]
    public class ListLessonExamController : Controller
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<ResourceUser> _lessonUserRepository;
        private readonly IGenericRepository<UserTest> _examUserRepository;

        public ListLessonExamController(PRN231_V2Context context)
        {
            _context = context;
            _lessonUserRepository = new GenericRepository<ResourceUser>(_context);
            _examUserRepository = new GenericRepository<UserTest>(_context);
        }

        //Check userId later
        // GET: /Student/ListLessonExam/GetLessons/5
        [HttpGet("GetLessons/{id}")]
        public async Task<ActionResult<IEnumerable<Resource>>> GetListLesson(int id)
        {
            var lessons = await _lessonUserRepository.GetAllAsync();
            lessons = lessons.Where(l => l.Resource.ResourceId == id);
            return Ok(lessons);
        }

        //Check userId later
        // GET: /Student/ListLessonExam/GetExams/5
        [HttpGet("GetExams/{id}")]
        public async Task<ActionResult<IEnumerable<Test>>> GetListExam(int id)
        {
            var exams = await _examUserRepository.GetAllAsync();
            exams = exams.Where(e => e.Test.CourseId == id);
            return Ok(exams);
        }
    }
}
