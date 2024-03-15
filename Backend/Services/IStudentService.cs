using Backend.Models;

namespace Backend.Services
{
    public interface IStudentService
    {
        Task<List<Course>> GetCoursesOfStudentAsync(int studentId);
    }
}
