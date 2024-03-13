using Backend.CustomizedExceptions;
using Backend.DTOs;
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

        public async Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid) { 
            return await repository.GetSingleCourseByIdAsync(teacherid, courseid);
        }

        public Task<Course> CreateCourseDraft(int teacherid, CourseDTO course)
        {
            if (string.IsNullOrEmpty(course.CourseName))
            {
                throw new ArgumentNullException("Course name cannot be empty");
            }
            var courseExisting = repository.GetCourseListByTeacher(teacherid);
            foreach(Course c in courseExisting)
            {
                if(c.CourseName.ToLower().Equals(course.CourseName.ToLower()))
                {
                    throw new RepeatedExeption("This course name has already existed");
                }
            }
            return repository.CreateCourseDraft(teacherid, course);
        }

    }
}
