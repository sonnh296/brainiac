using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers.Sudent
{
    [Route("Student/[controller]")]
    [ApiController]
    public class LessonDetailController : Controller
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<Resource> _lessonRepository;
        private readonly IGenericRepository<ResourceUser> _lessonUserRepository;

        public LessonDetailController(PRN231_V2Context context)
        {
            _context = context;
            _lessonRepository = new GenericRepository<Resource>(_context);
            _lessonUserRepository = new GenericRepository<ResourceUser>(_context);
        }

        // GET: /Student/LessonDetail/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Resource>> GetLessonDetail(int id)
        {
            var lesson = await _lessonRepository.GetByIdAsync(id);
            if(lesson != null)
            {
                return Ok(lesson);
            }
            else
            {
                return NotFound();
            }
        }

        //Check userId later
        // PUT: /Student/LessonDetail/CompleteLesson/5
        [HttpPut("CompleteLesson/{id}")]
        public async Task<IActionResult> CompleteLesson(int id)
        {
            var lesson = await _lessonUserRepository.GetByIdAsync(id);
            if(lesson != null)
            {
                lesson.IsComplete = true;
                _lessonUserRepository.Update(lesson);
                await _lessonUserRepository.SaveAsync();
                return Ok();
            }
            else
            {
                return NotFound();
            }
        }
    }
}
