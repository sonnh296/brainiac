using AutoMapper;
using Backend.DTOs.Resource;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class ResourceRepository
    {
        private readonly PRN231_V2Context context;
        private readonly IMapper mapper;

        public ResourceRepository(PRN231_V2Context _context, IMapper map)
        {
            context = _context;
            mapper = map;
        }

        public Resource GetLargestOrdinalResourceInCourse(int courseId)
        {
            var resource = context.Resources
                            .Where(r => r.CourseId == courseId
                             && r.OrdinalNumber == context.Resources.Where(lc => lc.CourseId == courseId).Max(lc => lc.OrdinalNumber))
                            .FirstOrDefault();
            return resource;
        }

        public async Task<List<Resource>> GetResourceListFromCourseAsync(int courseId)
        {
            var resources = await context.Resources.Where(r => r.CourseId == courseId).ToListAsync();
            return resources;
        }

        public List<Resource> GetResourceListInACourse(int courseId)
        {
            var resources = context.Resources.Where(r => r.CourseId == courseId).ToList();
            return resources;
        }

        public async Task<Resource?> UpdateResourceFromCourseAsync(int id, ResourceUpdateDTO resource)
        {
            var resourceToUpdate = await context.Resources.Where(r => r.ResourceId == id).FirstOrDefaultAsync();
            if(resourceToUpdate == null)
            {
                return null;
            }
            if (string.IsNullOrEmpty(resource.Name))
            {
                resourceToUpdate.Name = resource.Name;
            }
            if (string.IsNullOrEmpty(resource.Description))
            {
                resourceToUpdate.Description = resource.Description;
            }
            if (string.IsNullOrEmpty(resource.Type))
            {
                resource.Type = resource.Type;
            }
            if (string.IsNullOrEmpty(resource.IsFree.ToString()))
            {
                resource.IsFree = resource.IsFree;
            }
            context.Entry(resourceToUpdate).State = EntityState.Modified;
            await context.SaveChangesAsync();
            return resourceToUpdate;
        }
    }
}
