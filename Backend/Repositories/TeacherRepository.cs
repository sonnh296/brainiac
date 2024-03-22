using AutoMapper;
using Backend.App.Constants;
using Backend.DTOs;
using Backend.DTOs.Course;
using Backend.DTOs.Resource;
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
                                       .Where(c => c.Status != CourseConstants.CourseDeleted)
                                       .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherId && uc.IsStudent == false))
                                       .Include(c => c.Resources)
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
            .Include(c => c.Resources)
            .Include(c => c.CategoryCourses)
            .ThenInclude(cc => cc.Category)
            .FirstOrDefaultAsync();

            return course;
        }

        public async Task<Course?> DeleteCourseByIdAsync(int teacherid, int courseId)
        {
            Course course = await FindCourseByIdAsync(courseId);
            if(course == null)
            {
                return null;
            }
            UserCourse uc = await context.UserCourses.Where(uc => uc.UserId == teacherid && uc.CourseId == courseId).FirstOrDefaultAsync();

            course.Status = CourseConstants.CourseDeleted;
            context.Entry(course).State = EntityState.Modified;

            uc.Status = CourseConstants.CourseDeleted;
            context.Entry(uc).State = EntityState.Modified;

            await context.SaveChangesAsync();
            return course;
        }
        public async Task<Course> FindCourseByIdAsync(int courseid)
        {
            var course = await context.Courses
            .Where(c => c.CourseId == courseid)
            .Include(c => c.Resources)
            .FirstOrDefaultAsync();

            return course;
        }

        public async Task<List<Course>> SearchCoursesOfTeacherByNameAsync(int teacherid, string keyword)
        {
            var courses = await context.Courses
                                .Where(c => c.UserCourses.Any(uc => uc.UserId == teacherid) 
                                 && c.CourseName.ToLower().Contains(keyword.ToLower()))
                                .ToListAsync();
            return courses;
        }

        public async Task<Course> CreateCourse(int teacherid, CourseCreateDTO courseDto)
        {
            var course = mapper.Map<Course>(courseDto);
            var selectedCategories = courseDto.Categories;
            course.Status = CourseConstants.CourseDraft;
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
            await context.SaveChangesAsync();
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
            await context.SaveChangesAsync();
            return listToAdd;
        }

        public List<Resource> GetResourceListInACourse(int courseId)
        {
            var resources = context.Resources.Where(r => r.CourseId == courseId).ToList();
            return resources;
        }

        public async Task<Resource> CreateResourceDraft(int courseid, ResourceCreateDTO rsCreate)
        {
            Resource res = mapper.Map<Resource>(rsCreate);
            res.CourseId = courseid;
            context.Resources.Add(res);
            await context.SaveChangesAsync();
            return res;
        }

        // edit course
        public async Task<Course?> UpdateCourse(int courseId, CourseUpdateDTO course)
        {
            Course? courseToUpdate = context.Courses.Where(c => c.CourseId == courseId).FirstOrDefault();
            if(courseToUpdate == null)
            {
                return null;
            }
            if(!string.IsNullOrEmpty(course.CourseName))
            {
                courseToUpdate.CourseName = course.CourseName;
            }
            if(!string.IsNullOrEmpty(course.Title))
            {
                courseToUpdate.Title = course.Title;
            }
            if(!string.IsNullOrEmpty(course.Price.ToString()))
            {
                courseToUpdate.Price = course.Price;
            }
            context.Entry(courseToUpdate).State = EntityState.Modified;
            await context.SaveChangesAsync();
            return courseToUpdate;
        }

    }
}