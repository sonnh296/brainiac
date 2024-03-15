using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class CategoryServiceImpl : ICategoryService
    {
        private readonly CategoryRepository repository;
        public CategoryServiceImpl(CategoryRepository rep)
        {
            repository = rep;
        }
        public Task<List<Category>> GetAllCategoriesAsync()
        {
            return repository.GetCategoriesAsync();
        }
    }
}
