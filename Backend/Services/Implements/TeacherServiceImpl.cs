using Backend.Models;
using Backend.Repositories;

namespace Backend.Service.Implement
{
    public class TeacherServiceImpl : ITeacherService
    {
        private readonly TeacherRepository repository;

        public TeacherServiceImpl(TeacherRepository repo)
        {
            repository = repo;
        }

        public async Task<List<Course>> GetCourseListByTeacherAsync(int id)
        {
            return await repository.GetCourseListByTeacherAsync(id);
        }
    }
}
