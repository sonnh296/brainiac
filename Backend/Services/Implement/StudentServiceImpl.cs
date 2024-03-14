using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class StudentServiceImpl : IStudentService
    {
        private readonly StudentRepository repo;
        public StudentServiceImpl(StudentRepository repo)
        {
            this.repo = repo;
        }
        public async Task<List<Course>> GetCoursesOfStudentAsync(int studentId)
        {
            return await repo.GetAllCourseOfStudent(studentId);
        }
    }
}
