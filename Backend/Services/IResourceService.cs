using Backend.Models;

namespace Backend.Services
{
    public interface IResourceService
    {
        Task<Resource> GetLargestOrdinalInCourse(int courseId);
    }
}
