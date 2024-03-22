using Backend.DTOs.Course;
using Backend.DTOs.Resource;
using Backend.Models;

namespace Backend.Services
{
    public interface ITeacherService
    {
        public Task<List<Course>> GetCourseListByTeacherAsync(int id);
        public Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid);
        public Task<Course> FindCourseByIdAsync(int courseid);
        public Task<Course> CreateCourseDraft(int teacherid, CourseCreateDTO course);
        public Task<Course?> UpdateCourseAsync(int courseId, CourseUpdateDTO course);
        public Task<List<Course>> SearchCourseByNameAsync(int teacherId, string keyword);
        public Task<List<Resource>> GetResourceListFromCourseAsync(int courseId);
        public Task<Resource> CreateResource(int courseId, ResourceCreateDTO resource);
    }
}