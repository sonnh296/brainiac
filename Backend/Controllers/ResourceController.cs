using AutoMapper;
using Backend.DTOs;
using Backend.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Backend.Services;

namespace Backend.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ResourceController : ControllerBase
    {
        private readonly IResourceService service;
        private readonly IMapper mapper;

        public ResourceController(IResourceService service, IMapper mapper)
        {
            this.service = service;
            this.mapper = mapper;
        }

        [HttpGet("GetLargestOrdinal/{courseId}")]
        public async Task<ActionResult<ResourceDTO>> GetResourceWithLargestOrdinalInCourse(int courseId)
        {
            Resource resource = await service.GetLargestOrdinalInCourse(courseId);
            var dto = mapper.Map<ResourceDTO>(resource);
            return Ok(dto);
        }
    }
}
