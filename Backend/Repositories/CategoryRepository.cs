using AutoMapper;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Repositories
{
    public class CategoryRepository
    {
        private readonly PRN231_V2Context context;
        private readonly IMapper mapper;

        public CategoryRepository(PRN231_V2Context _context, IMapper map)
        {
            context = _context;
            mapper = map;
        }

        public async Task<List<Category>> GetCategoriesAsync()
        {
            var cates = await context.Categories.ToListAsync();
            return cates;
        }
    }
}
