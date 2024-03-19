using AutoMapper;
using Backend.DTOs;
using Backend.DTOs.Course;
using Backend.Models;
using System.IO;

namespace Backend.Configurations
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            //map from course to dto
            //CreateMap<Course, CourseDTO>();
            CreateMap<Course, CourseDTO>()
            .ForMember(dto => dto.Categories, opt => opt.MapFrom(src => src.CategoryCourses.Select(cc => cc.Category)));
            CreateMap<CourseDTO, Course>();
            CreateMap<Course, CourseCreateDTO>();
            CreateMap<CourseCreateDTO, Course>();
            CreateMap<Category, CategoryDTO>();
            CreateMap<CategoryDTO, Category>();

            CreateMap<Resource, ResourceDTO>();
            CreateMap<ResourceDTO, Resource>();
            CreateMap<Resource, ResourceDisplayDTO>();
            CreateMap<ResourceDisplayDTO, Resource>();
        }
    }
}
