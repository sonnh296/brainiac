using Backend.CustomizedExceptions;
using Backend.DTOs.Course;
using Backend.DTOs.Resource;
using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class TeacherServiceImpl : ITeacherService
    {
        private readonly TeacherRepository teacherRepo;
        private readonly ResourceRepository resourceRepo;

        public TeacherServiceImpl(TeacherRepository repo, ResourceRepository resourceRepository)
        {
            teacherRepo = repo;
            this.resourceRepo = resourceRepository;
        }

        public async Task<List<Course>> GetCourseListByTeacherAsync(int id)
        {
            return await teacherRepo.GetCourseListByTeacherAsync(id);
        }

        public async Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid)
        {
            return await teacherRepo.GetSingleCourseByIdAsync(teacherid, courseid);
        }

        public Task<Course> CreateCourseDraft(int teacherid, CourseCreateDTO course)
        {
            if (string.IsNullOrEmpty(course.CourseName))
            {
                throw new ArgumentNullException();
            }
            var courseExisting = teacherRepo.GetCourseListByTeacher(teacherid);
            foreach (Course c in courseExisting)
            {
                if (c.CourseName.ToLower().Equals(course.CourseName.ToLower()))
                {
                    throw new RepeatedExeption();
                }
            }
            return teacherRepo.CreateCourse(teacherid, course);
        }

        public Task<Resource> CreateResource(int courseId, ResourceCreateDTO resource)
        {
            if (string.IsNullOrEmpty(resource.Name))
            {
                throw new ArgumentNullException();
            }
            var resources = resourceRepo.GetResourceListInACourse(courseId);
            foreach (Resource r in resources)
            {
                if(r.Name.ToLower().Equals(resource.Name.ToLower())) {
                    throw new RepeatedExeption();
                }
            }
            Resource latestResourceInCourse = resourceRepo.GetLargestOrdinalResourceInCourse(courseId);
            return teacherRepo.CreateResourceDraft(courseId, latestResourceInCourse, resource);
        }

        public Task<Course?> UpdateCourseAsync(int courseId, CourseUpdateDTO course)
        {
            if(string.IsNullOrEmpty(course.CourseName) || string.IsNullOrEmpty(course.Title))
            {
                throw new ArgumentNullException();
            }
            return teacherRepo.UpdateCourse(courseId, course);
        }

        public Task<List<Course>> SearchCourseByNameAsync(int teacherId, string keyword)
        {
            return teacherRepo.SearchCoursesOfTeacherByNameAsync(teacherId, keyword);
        }

        public Task<Course> FindCourseByIdAsync(int courseid)
        {
            return teacherRepo.FindCourseByIdAsync(courseid);
        }

        public async Task<Course?> DeleteCourseAsync(int teacherId, int courseId)
        {
            return await teacherRepo.DeleteCourseByIdAsync(teacherId, courseId);
        }

        public Task<List<Resource>> GetResourceListFromCourseAsync(int courseId)
        {
            return resourceRepo.GetResourceListFromCourseAsync(courseId);
        }

        public Task<Resource?> UpdateResourceAsync(int resid, ResourceUpdateDTO resource)
        {
            return resourceRepo.UpdateResourceFromCourseAsync(resid, resource);
        }

        public Task<Test?> AddTestToCourse(int course, Test test)
        {
            throw new NotImplementedException();
        }
    }
}
