using Backend.DTOs;
using Backend.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Backend.Repositories
{
    public class HomeRepository : IHomeRepository
    {
        private readonly PRN231_V2Context _context;
        public HomeRepository(PRN231_V2Context context)
        {
            _context = context;
        }

        public List<Course> GetAllCourse()
        {
            return _context.Courses.ToList();
        }

        public List<CourseRatingDTO> GetCourseByCate(int cate)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<CategoryCourse> categoryCourses = _context.CategoryCourses.Where(x => x.CategoryId == cate).ToList();
            List<Course> result = new List<Course>();
            foreach (CategoryCourse category in categoryCourses)
            {
                result.Add(_context.Courses.FirstOrDefault(x => x.CourseId == category.CourseId));
            }

            foreach (Course rating in result)
            {

                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }

            return resultcourses.Where(x=>x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseByCatePrice(int cate, int ratefrom, int rateto)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<CategoryCourse> categoryCourses = _context.CategoryCourses.Where(x => x.CategoryId == cate).ToList();
            List<Course> result = new List<Course>();
            foreach (CategoryCourse category in categoryCourses)
            {
                result.Add(_context.Courses.FirstOrDefault(x => x.CourseId == category.CourseId));
            }
            result = result.Where(x => ratefrom < x.Price && x.Price < rateto).ToList();

            foreach (Course rating in result)
            {

                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }

            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseByPrice(int ratefrom, int rateto)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<Course> result = new List<Course>();

            result = _context.Courses.Where(x => ratefrom < x.Price && x.Price < rateto).ToList();
            foreach (Course rating in result)
            {
              
                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }
            
            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseBySearch(string search)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<Course> result = new List<Course>();
           
            result = _context.Courses.Where(x => x.CourseName.ToLower().Contains(search.ToLower())).ToList();
         
            foreach (Course rating in result)
            {
              
                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }
            
            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseBySearchCate(string search, int cate)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<CategoryCourse> categoryCourses = _context.CategoryCourses.Where(x => x.CategoryId == cate).ToList();
            List<Course> result = new List<Course>();
            foreach (CategoryCourse category in categoryCourses)
            {
                result.Add(_context.Courses.FirstOrDefault(x => x.CourseId == category.CourseId));
            }
            result = result.Where(x => x.CourseName.ToLower().Contains(search.ToLower())).ToList();

            foreach (Course rating in result)
            {

                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }

            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseBySearchCatePrice(string search, int cate, int ratefrom, int rateto)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<CategoryCourse> categoryCourses = _context.CategoryCourses.Where(x=>x.CategoryId==cate).ToList();
            List<Course> result = new List<Course>();
            foreach (CategoryCourse category in categoryCourses)
            {
                result.Add(_context.Courses.FirstOrDefault(x => x.CourseId == category.CourseId));
            }
            result = result.Where(x => x.CourseName.ToLower().Contains(search.ToLower()) && ratefrom < x.Price && x.Price < rateto).ToList();
         
            foreach (Course rating in result)
            {
              
                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }
            
            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<CourseRatingDTO> GetCourseBySearchPrice(string search, int ratefrom, int rateto)
        {
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            List<Course> result = new List<Course>();
           
            result = _context.Courses.Where(x => x.CourseName.ToLower().Contains(search.ToLower()) && ratefrom < x.Price && x.Price < rateto).ToList();

            foreach (Course rating in result)
            {

                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = rating.CourseId;
                ratingDTO.CourseName = rating.CourseName;
                ratingDTO.Title = rating.Title;
                ratingDTO.Price = rating.Price;
                ratingDTO.Status = rating.Status;
                resultcourses.Add(ratingDTO);

            }

            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }

        public List<SortRatingDTO> GetPopularCourse2()
        {
            List<SortRatingDTO> sortRatingDTOs = new List<SortRatingDTO>();

            List<Course> courses = _context.Courses.ToList();
            foreach (Course course in courses)
            {
                List<Rating> ratings = _context.Ratings.Where(x => x.CourseId == course.CourseId).ToList();
                int totalrate = 0;
                foreach (Rating rating in ratings)
                {
                    if (rating.Point != null)
                    {
                        //totalrate += rating.Point;
                    }

                }
                SortRatingDTO sortRatingDTO = new SortRatingDTO();
                sortRatingDTO.CourseId = course.CourseId;
                sortRatingDTO.totalrate = totalrate;

                sortRatingDTOs.Add(sortRatingDTO);
            }
            List<Course> resultcourses = new List<Course>();
            courses = _context.Courses.ToList();
            List<SortRatingDTO> SortedList = sortRatingDTOs.OrderBy(o => o.totalrate).ToList();
           
            return SortedList;
            /*  // Fetch courses and ratings from the database
              List<Course> courses = _context.Courses.ToList();
              List<Rating> ratings = _context.Ratings.ToList();

              // Dictionary to store total points for each course
              Dictionary<Course, int> courseTotalPoints = new Dictionary<Course, int>();

              // Calculate total points for each course
              foreach (var course in courses)
              {
                  int totalPoints = 0;
                  foreach (var rating in ratings)
                  {
                      if (rating.CourseId == course.CourseId)
                      {
                          totalPoints += rating.Point;
                      }
                  }
                  courseTotalPoints.Add(course, totalPoints);
              }

              // Sort courses by total points
              List<Course> sortedCourses = new List<Course>();
              foreach (var kvp in courseTotalPoints.OrderByDescending(kvp => kvp.Value))
              {
                  sortedCourses.Add(kvp.Key);
              }
              return sortedCourses;*/

        }

        public List<CourseRatingDTO> GetPopularCourse()
        {
            List<SortRatingDTO> sortRatingDTOs = new List<SortRatingDTO>();

            List<Course> courses = _context.Courses.ToList();
            foreach (Course course in courses)
            {
                List<Rating> ratings = _context.Ratings.Where(x => x.CourseId == course.CourseId).ToList();
                int totalrate = 0;
                foreach (Rating rating in ratings)
                {
                    if (rating.Point != null)
                    {
                        //totalrate += rating.Point;
                    }

                }
                SortRatingDTO sortRatingDTO = new SortRatingDTO();
                sortRatingDTO.CourseId = course.CourseId;
                sortRatingDTO.totalrate = totalrate;

                sortRatingDTOs.Add(sortRatingDTO);
            }
            List<CourseRatingDTO> resultcourses = new List<CourseRatingDTO>();
            courses = _context.Courses.ToList();
            List<SortRatingDTO> SortedList = sortRatingDTOs.OrderBy(o => o.totalrate).ToList();

            foreach (SortRatingDTO rating in SortedList)
            {
                Course course = courses.FirstOrDefault(x => x.CourseId == rating.CourseId);
                CourseRatingDTO ratingDTO = new CourseRatingDTO();
                ratingDTO.CourseId = course.CourseId;
                ratingDTO.CourseName = course.CourseName;
                ratingDTO.Title = course.Title;
                ratingDTO.Price = course.Price;
                ratingDTO.Status = course.Status;
                resultcourses.Add(ratingDTO);

            }
            return resultcourses.Where(x => x.Status.Equals("1") || x.Status.Equals("approved")).ToList();
        }
    }
}
