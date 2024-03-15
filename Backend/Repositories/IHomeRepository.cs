using Backend.DTOs;
using Backend.Models;

namespace Backend.Repositories
{
    public interface IHomeRepository
    {
        List<Course> GetAllCourse();
        List<CourseRatingDTO> GetPopularCourse();
        List<SortRatingDTO> GetPopularCourse2();
        List<CourseRatingDTO> GetCourseBySearchCatePrice(string search, int cate, int ratefrom, int rateto);
        List<CourseRatingDTO> GetCourseBySearch(string search);
        List<CourseRatingDTO> GetCourseByCate(int cate);
        List<CourseRatingDTO> GetCourseByPrice(int ratefrom, int rateto);
        List<CourseRatingDTO> GetCourseBySearchCate(string search, int cate);
        List<CourseRatingDTO> GetCourseBySearchPrice(string search, int ratefrom, int rateto);
        List<CourseRatingDTO> GetCourseByCatePrice(int cate, int ratefrom, int rateto);

    }
}
