using AutoMapper;
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

        public async Task<Resource> GetLargestOrdinalResourceInCourse(int courseId)
        {
            var resource = await context.Resources
                            .Where(r => r.CourseId == courseId && r.OrdinalNumber == context.Resources.Where(lc => lc.CourseId == courseId).Max(lc => lc.OrdinalNumber))
                            .FirstOrDefaultAsync();
            return resource;
        }
    }
}
