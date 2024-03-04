using Backend.DTOs;
using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly PRN231_V2Context _context;
        private readonly IHomeRepository _homeRepository;
       

        public HomeController(PRN231_V2Context context)
        {
            _context = context;
            _homeRepository = new HomeRepository(_context);
        }


        //Get list related courses
        // GET: /Student/CourseDetail/5
        [HttpGet("GetNewestCourse")]
        public async Task<ActionResult<IEnumerable<Course>>> GetNewestCourse()
        {

            List<Course> course = _homeRepository.GetAllCourse();

            if (course != null)
            {
               

                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetPopularCourse")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetPopularCourse()
        {

            List<CourseRatingDTO> course = _homeRepository.GetPopularCourse();

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseBySearchCatePrice")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseBySearchCatePrice(string search, int cate, int price)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseBySearchCatePrice(search,cate,price);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseBySearchCate")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseBySearchCate(string search, int cate)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseBySearchCate(search, cate);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseBySearchPrice")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseBySearchPrice(string search, int price)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseBySearchPrice(search, price);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseByCatePrice")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseByCatePrice(int cate, int price)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseByCatePrice(cate, price);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseBySearch")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseBySearch(string search)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseBySearch(search);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseByCate")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseByCate( int cate)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseByCate(cate);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
        [HttpGet("GetCourseByPrice")]
        public async Task<ActionResult<IEnumerable<CourseRatingDTO>>> GetCourseByPrice(int price)
        {

            List<CourseRatingDTO> course = _homeRepository.GetCourseByPrice(price);

            if (course != null)
            {


                return Ok(course);
            }
            else
            {
                return NotFound();
            }
        }
    }
}
