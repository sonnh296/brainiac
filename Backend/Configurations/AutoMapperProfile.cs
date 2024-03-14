using AutoMapper;
using Backend.DTOs;
using Backend.Models;

namespace Backend.Configurations
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Course, CourseDTO>();
            CreateMap<CourseDTO, Course>();
        }
    }
}
