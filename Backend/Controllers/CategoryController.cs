using AutoMapper;
using Backend.DTOs;
using Backend.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService service;
        private readonly IMapper mapper;
        public CategoryController(ICategoryService s, IMapper m)
        {
            service = s;
            mapper = m;
        }

        // get category list
        [HttpGet("getAll")]
        public async Task<ActionResult<List<CategoryDTO>>> GetAllCategoriesAsync()
        {
            var cates = await service.GetAllCategoriesAsync();
            var dtos = mapper.Map<List<CategoryDTO>>(cates);
            return Ok(dtos);
        }
    }
}
