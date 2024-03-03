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
        private readonly IGenericRepository<Resource> _lessonRepository;
        private readonly IGenericRepository<Test> _examRepository;

        public ListLessonExamController(PRN231_V2Context context)
        {
            _context = context;
            _lessonRepository = new GenericRepository<Resource>(_context);
            _examRepository = new GenericRepository<Test>(_context);
        }

        [HttpGet("GetLessons/{id}")]
        public async Task<ActionResult<IEnumerable<Resource>>> GetListLesson(int id)
        {
            var lessons = await _lessonRepository.GetAllAsync();
            lessons = lessons.Where(l => l.CourseId == id);
            return Ok(lessons);
        }

        [HttpGet("GetExams/{id}")]
        public async Task<ActionResult<IEnumerable<Test>>> GetListExam(int id)
        {
            var exams = await _examRepository.GetAllAsync();
            exams = exams.Where(e => e.CourseId == id);
            return Ok(exams);
        }
    }
}
