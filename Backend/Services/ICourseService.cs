using Backend.Models;

namespace Backend.Services
{
    public interface ICourseService
    {
        Task<IEnumerable<Course>> GetAllAsync();

        Task<Course> GetByIdAsync(int id);

        Task<IEnumerable<Course>> GetCoursesOfUserAsync(int userId);
    }
}
