using AutoMapper;
using Backend.DTOs;
using Backend.Repositories;
using Backend.Services;
using Backend.Services.Implement;

namespace Backend.App.Extensions
{
    public static class AppServiceExtentions
    {
        public static void AddAppServices(this IServiceCollection services)
        {
            services.AddScoped<ITeacherService, TeacherServiceImpl>();
            services.AddScoped<TeacherRepository>();
            services.AddScoped<ICategoryService, CategoryServiceImpl>();
            services.AddScoped<CategoryRepository>();
        }
    }
}