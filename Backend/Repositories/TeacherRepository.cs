using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class TeacherRepository
    {
        private readonly PRN231_V2Context context;

        public TeacherRepository(PRN231_V2Context _context)
        {
            context = _context;
        }

        public async Task<List<Course>> GetCourseListByTeacherAsync(int teacherId)
        {
            var courses = await context.Courses
            .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherId))
            .ToListAsync();

            return courses;
        }
    }
}
