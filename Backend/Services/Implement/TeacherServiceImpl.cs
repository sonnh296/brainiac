﻿using Backend.CustomizedExceptions;
using Backend.DTOs;
using Backend.DTOs.Course;
using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
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

        public async Task<Course> GetSingleCourseByIdAsync(int teacherid, int courseid)
        {
            return await repository.GetSingleCourseByIdAsync(teacherid, courseid);
        }

        public Task<Course> CreateCourseDraft(int teacherid, CourseCreateDTO course)
        {
            if (string.IsNullOrEmpty(course.CourseName))
            {
                throw new ArgumentNullException("Course name cannot be empty");
            }
            var courseExisting = repository.GetCourseListByTeacher(teacherid);
            foreach (Course c in courseExisting)
            {
                if (c.CourseName.ToLower().Equals(course.CourseName.ToLower()))
                {
                    throw new RepeatedExeption("This course name has already existed");
                }
            }
            return repository.CreateCourse(teacherid, course);
        }

        public Task<Resource> CreateResource(ResourceDTO resource)
        {
            return null;
        }
    }
}
