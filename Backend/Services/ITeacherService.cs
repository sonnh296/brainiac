using Backend.Models;

namespace Backend.Service
{
    public interface ITeacherService
    {
        public Task<List<Course>> GetCourseListByTeacherAsync(int id);
    }
}
