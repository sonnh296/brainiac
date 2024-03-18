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

            services.AddScoped<IStudentService, StudentServiceImpl>();
            services.AddScoped<StudentRepository>();

            services.AddScoped<IResourceService, ResourceServiceImpl>();
            services.AddScoped<ResourceRepository>();
        }
    }
}