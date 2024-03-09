using Backend.Models;

namespace Backend.Repositories
{
    public interface ICourseRepository
    {
        IEnumerable<Course> GetAll();
        Course GetById(int id);
        void Create(Course course);
        void Update(Course course);
        void Delete(Course course);
    }
}
