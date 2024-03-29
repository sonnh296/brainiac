﻿using Backend.DTOs;
using Backend.Models;
using Backend.Services;
using Backend.Services.Implement;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : BaseApiController
    {
        private readonly PRN231_V2Context _context;
        public CourseController(PRN231_V2Context context)
        {
            _context = context;
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("CourseDetail/{id}")]
        public async Task<IActionResult> GetCourseDetailAsync(int id)
        {
            bool isEnrolled = _context.UserCourses.Any(x => x.CourseId == id && x.UserId == UserID && x.IsStudent == true);

            var course = _context.Courses
                .Include(x => x.Resources)
                .FirstOrDefault(x => x.CourseId == id);
            if(course == null)
            {
                return NotFound();
            }
            var test = _context.UserCourses.Where(uc => uc.CourseId==id).ToList();
            var author = _context.UserCourses
                .Include(x => x.User)
                .FirstOrDefault(x => x.CourseId == id && x.IsStudent == false)?
                .User;
            var listCategory = _context.CategoryCourses
                .Where(x => x.Course.CourseId == id).Select(x => x.Category);
            int countEnrolled = _context.UserCourses.Where(x => x.CourseId == id && x.IsStudent == true).Count();
            bool isRated = _context.Ratings.Any(x => x.CourseId == id && x.UserId == UserID);

            var obj = new
            {
                CourseId = course.CourseId,
                Name = course.CourseName,
                Description = course.Title,
                Lessons = course.Resources.Count(),
                Price = course.Price,
                Author = new {UserId = author.UserId, UserName = author.UserName},
                Categories = listCategory,
                Enrolled = countEnrolled,
                IsEnrolled = isEnrolled,
                UserId = UserID,
                IsRated = isRated,
            };
            return Ok(obj);
        }

		
		[HttpGet("Related/{id}")]
        public async Task<IActionResult> GetRelatedCoursesAsync(int id)
        {
            var course = _context.Courses.FirstOrDefault(x => x.CourseId == id);
            if(course == null)
            {
                return NotFound();
            }
            var listCategory = _context.CategoryCourses
                .Where(x => x.Course.CourseId == id).Select(x => x.Category);
            var listCourse = _context.CategoryCourses
                .Where(x => listCategory.Any(c => c.CategoryId == x.CategoryId) && x.CourseId != id)
                .Select(x => new
                {
                    CourseId = x.CourseId,
                    Name = x.Course.CourseName,
                    Description = x.Course.Title,
                    Author = x.Course.UserCourses.FirstOrDefault(x => x.IsStudent == false).User,
                    Categories = x.Course.CategoryCourses.Select(c => c.Category),
                    Price = x.Course.Price
                });
            return Ok(listCourse);
        }

		
		[HttpGet("CourseByTeacher/{teacherId}")]
        public async Task<IActionResult> GetCourseByTeacherAsync(int teacherId)
        {
            var teacher = _context.Users.FirstOrDefault(x => x.UserId == teacherId);
            if(teacher == null)
            {
                return NotFound();
            }
            var listCourse = _context.Courses
                .Include(x => x.UserCourses)
                .ThenInclude(x => x.User)
                .Where(x => x.UserCourses.Any(x => x.UserId == teacherId && x.IsStudent == false))
                .Select(x => new
                {
                    TeacherName = teacher.UserName,
                    CourseId = x.CourseId,
                    Name = x.CourseName,
                    Description = x.Title,
                    Categories = x.CategoryCourses.Select(c => c.Category),
                    Price = x.Price
                });
            return Ok(listCourse);
        }

	
		[HttpGet("CourseByCategory/{categoryId}")]
        public async Task<IActionResult> GetCourseByCategoryAsync(int categoryId)
        {
            var category = _context.Categories.FirstOrDefault(x => x.CategoryId == categoryId);
            if(category == null)
            {
                return NotFound();
            }
            var listCourse = _context.CategoryCourses
                .Where(x => x.CategoryId == categoryId)
                .Select(x => new
                {
                    CategoryName = category.CategoryName,
                    CourseId = x.CourseId,
                    Name = x.Course.CourseName,
                    Description = x.Course.Title,
                    Author = x.Course.UserCourses.FirstOrDefault(x => x.IsStudent == false).User,
                    Categories = x.Course.CategoryCourses.Select(c => c.Category),
                    Price = x.Course.Price
                });
            return Ok(listCourse);
        }

        [Authorize(Roles = "Student")]
        [HttpPost("EnrollCourse")]
        public async Task<IActionResult> EnrollCourseAsync(UserCourseDTO userCourseDTO)
        {
            var userCourse = new UserCourse
            {
                UserId = userCourseDTO.UserId,
                CourseId = userCourseDTO.CourseId
            };
            try
            {
                userCourse.IsStudent = true;
                userCourse.Status = "1";
                _context.UserCourses.Add(userCourse);

                var resource = _context.Resources
                    .Where(x => x.CourseId == userCourseDTO.CourseId)
                    .Select(x => new ResourceUser
                    {
                        UserId = userCourseDTO.UserId,
                        ResourceId = x.ResourceId,
                        IsComplete = false
                    });
                _context.ResourceUsers.AddRange(resource);
                await _context.SaveChangesAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            
        }

        [Authorize(Roles = "Student")]
        [HttpGet("MyCourses")]
        public async Task<IActionResult> GetMyCoursesAsync()
        {
            //var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = UserID;
            //if (identity != null)
            //{
            //    IEnumerable<Claim> claims = identity.Claims;
            //    // or
            //    userID = Int32.Parse(identity.FindFirst("ID").Value);
            //}
            var listCourse = _context.UserCourses
                .Include(x => x.Course)
                .Include(x => x.User)
                .Where(x => x.UserId == userID && x.IsStudent == true)
                .Select(x => new
                {
                    CourseId = x.CourseId,
                    Name = x.Course.CourseName,
                    Description = x.Course.Title,
                    Author = x.Course.UserCourses.FirstOrDefault(x => x.IsStudent == false).User.UserName,
                });
            return Ok(listCourse);
        }
    }
}
