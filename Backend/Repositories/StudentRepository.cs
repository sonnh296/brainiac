using Backend.DTOs;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class StudentRepository
    {
        private readonly PRN231_V2Context context;

        public StudentRepository(PRN231_V2Context _context)
        {
            context = _context;
        }

        public async Task<List<Course>> GetAllCourseOfStudent(int studentId)
        {
            var courses = await context.Courses
                          .Where(c => c.UserCourses.Any(uc => uc.UserId == studentId && uc.IsStudent == true))
                          .Include(c => c.CategoryCourses)
                          .ThenInclude(cc => cc.Category)
                          .ToListAsync();
            return courses;
        }

    }
}
