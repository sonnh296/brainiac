using Backend.Repositories;
using Backend.Service;
using Backend.Service.Implement;

namespace Backend.App.Extensions
{
    public static class AppServiceExtentions
    {
        public static void AddAppServices(this IServiceCollection services)
        {
            services.AddScoped<ITeacherService, TeacherServiceImpl>();
            services.AddScoped<TeacherRepository>();
        }
    }
}
