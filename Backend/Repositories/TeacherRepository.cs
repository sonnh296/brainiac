using AutoMapper;
using Backend.App.Constants;
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
            var courses = await context.Courses
                                       .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherId && uc.IsStudent == false))
                                       .Include(c => c.CategoryCourses)
                                       .ThenInclude(cc => cc.Category)
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
            .Include(c => c.CategoryCourses)
            .ThenInclude(cc => cc.Category)
            .FirstOrDefaultAsync();

            return course;
        }

        public async Task<Course> CreateCourseDraft(int teacherid, CourseDTO courseDto)
        {
            var course = mapper.Map<Course>(courseDto);
            var selectedCategories = courseDto.Categories;
            context.Courses.Add(course);
            await context.SaveChangesAsync();
            await ModifyUserCourseInfo(teacherid, course, CourseConstants.CourseDraft);
            await ModifyCategoryCourseInfo(course, selectedCategories);
            return course;
        }

        public async Task<UserCourse> ModifyUserCourseInfo(int teacherid, Course course, string status)
        {
            var userCourse = new UserCourse()
            {
                UserId = teacherid,
                CourseId = course.CourseId,
                IsStudent = false,
                Status = status
            };
            context.UserCourses.Add(userCourse);
            //await context.SaveChangesAsync();
            return userCourse;
        }

        public async Task<List<CategoryCourse>> ModifyCategoryCourseInfo(Course course, List<CategoryDTO> selectedCategories)
        {
            var listToAdd = new List<CategoryCourse>();
            foreach(var category in selectedCategories)
            {
                CategoryCourse categoryCourse = new()
                {
                    CategoryId = category.CategoryId,
                    CourseId = course.CourseId,
                };
                listToAdd.Add(categoryCourse);
            }
            // add cate course into db
            context.CategoryCourses.AddRange(listToAdd);
            //await context.SaveChangesAsync();
            return listToAdd;
        }
    }
}