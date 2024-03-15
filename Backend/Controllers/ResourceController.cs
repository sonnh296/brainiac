using Backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.AccessControl;
using System.Security.Claims;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ResourceController : Controller
    {
        private readonly PRN231_V2Context _context;
        public ResourceController(PRN231_V2Context context)
        {
            _context = context;
        }

        [HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetResourcesOfCourseAsync(int courseId)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = -1;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;
                // or
                userID = Int32.Parse(identity.FindFirst("ID").Value);
            }

            var resources = _context.ResourceUsers
                .Include(x => x.Resource)
                .Where(x => x.Resource.CourseId == courseId && x.UserId == userID)
                .Select(x => new
                {
                    ResourceId = x.Resource.ResourceId,
                    Name = x.Resource.Name,
                    Description = x.Resource.Description,
                    Type = x.Resource.Type,
                    OrdinalNumber = x.Resource.OrdinalNumber,
                    IsComplete = x.IsComplete
                })
                .OrderBy(x => x.OrdinalNumber);
            if(resources == null)
            {
                return NoContent();
            }
            return Ok(resources);
        }

        [HttpGet("Resource/{resourceId}")]
        public async Task<IActionResult> GetResourceDetailAsync(int resourceId)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = -1;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;
                // or
                userID = Int32.Parse(identity.FindFirst("ID").Value);
            }

            var resource = _context.ResourceUsers
                .Include(x => x.Resource)
                .Select(x => new
                {
                    ResourceId = x.Resource.ResourceId,
                    Content = x.Resource.Content,
                    Name = x.Resource.Name,
                    Description = x.Resource.Description,
                    Type = x.Resource.Type,
                    IsComplete = x.IsComplete,
                    UserId = x.UserId
                })
                .FirstOrDefault(x => x.ResourceId == resourceId && x.UserId == userID);
            if(resource == null)
            {
                return NoContent();
            }
            return Ok(resource);
        }

        [HttpPost("CompleteResource/{resourceId}")]
        public async Task<IActionResult> CompleteResourceAsync(int resourceId)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = -1;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;
                // or
                userID = Int32.Parse(identity.FindFirst("ID").Value);
            }

            var resourceUser = _context.ResourceUsers
                .FirstOrDefault(x => x.ResourceId == resourceId && x.UserId == userID);
            if(resourceUser == null)
            {
                return NoContent();
            }
            resourceUser.IsComplete = true;
            _context.Update(resourceUser);
            await _context.SaveChangesAsync();
            return Ok("Completed successfully!!!");
        }
    }
}
