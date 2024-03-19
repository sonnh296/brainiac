using Backend.DTOs;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class CourseRepository : ICourseRepository
    {
        private readonly PRN231_V2Context _context = new PRN231_V2Context();

        public IEnumerable<Course> GetAll()
        {
            return  _context.Courses.ToList();
        }
        public Course GetById(int id)
        {
            return  _context.Courses.FirstOrDefault(x => x.CourseId == id);
        }
        public void Create(Course course)
        {
            _context.Courses.Add(course);
            _context.SaveChanges();
        }
        public void Update(Course course)
        {
            _context.Courses.Update(course);
            _context.SaveChanges();
        }
        public void Delete(Course course)
        {
            _context.Courses.Remove(course);
            _context.SaveChanges();
        }

    }
}
