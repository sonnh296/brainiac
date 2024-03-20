using Backend.DTOs.Course;
using Backend.DTOs.Resource;
using Backend.Models;

namespace Backend.Services
{
    public interface ITeacherService
    {
        public Task<List<Course>> GetCourseListByTeacherAsync(int id);
        public Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid);
        public Task<Course> CreateCourseDraft(int teacherid, CourseCreateDTO course);
        public Task<Resource> CreateResource(int courseId, ResourceCreateDTO resource);
    }
}