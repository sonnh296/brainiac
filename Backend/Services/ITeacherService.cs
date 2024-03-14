using Backend.DTOs;
using Backend.Models;

namespace Backend.Services
{
    public interface ITeacherService
    {
        public Task<List<Course>> GetCourseListByTeacherAsync(int id);
        public Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid);
        public Task<Course> CreateCourseDraft(int teacherid, CourseDTO course);
    }
}