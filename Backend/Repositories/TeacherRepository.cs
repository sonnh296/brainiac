using AutoMapper;
using Backend.DTOs;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class TeacherRepository
    {
        private readonly PRN231_V2Context context;
        private readonly IMapper mapper;

        public TeacherRepository(PRN231_V2Context _context, IMapper map)
        {
            context = _context;
            mapper = map;
        }

        public async Task<List<Course>> GetCourseListByTeacherAsync(int teacherId)
        {
            var courses = await context.Courses.Include("UserCourses")
                                       .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherId && uc.IsStudent == false))
                                       .ToListAsync();
            return courses;
        }

        public List<Course> GetCourseListByTeacher(int teacherId)
        {
            var courses = context.Courses
                            .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherId && uc.IsStudent == false))
                            .ToList();
            return courses;
        }

        public async Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid)
        {
            var course = await context.Courses
            .Where(c => c.CourseId == courseid && c.UserCourses.Any(uc => uc.UserId == teacherid && uc.IsStudent == false))
            .FirstOrDefaultAsync();

            return course;
        }

        public async Task<Course> CreateCourseDraft(int teacherid, CourseDTO courseDto)
        {
            var course = mapper.Map<Course>(courseDto);
            context.Courses.Add(course);
            var userCourse = new UserCourse()
            {
                UserId = teacherid,
                CourseId = course.CourseId,
                IsStudent = false,
                Status = "Draft"
            };
            context.UserCourses.Add(userCourse);
            //await context.SaveChangesAsync();
            return course;
        }
    }
}
