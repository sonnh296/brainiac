using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class CourseServiceImpl : ICourseService
    {

        ICourseRepository _courseRepository = new CourseRepository();
        public async Task<IEnumerable<Course>> GetAllAsync()
        {
            return  _courseRepository.GetAll();
        }

        public async Task<Course> GetByIdAsync(int id)
        {
            return  _courseRepository.GetById(id);
        }
        
        public async Task<IEnumerable<Course>> GetCoursesOfUserAsync(int userId)
        {
            return  _courseRepository.GetAll().Where(c => c.UserCourses.Any(uc => uc.UserId==userId));
        }
    }
}
