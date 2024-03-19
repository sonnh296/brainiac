using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class ResourceServiceImpl : IResourceService
    {
        private readonly ResourceRepository repository;

        public ResourceServiceImpl(ResourceRepository repository)
        {
            this.repository = repository;
        }

        public async Task<Resource> GetLargestOrdinalInCourse(int courseId)
        {
            return await repository.GetLargestOrdinalResourceInCourse(courseId);
        }
    }
}
