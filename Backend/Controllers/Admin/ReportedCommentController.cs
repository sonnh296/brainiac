using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace Backend.Controllers.Admin
{
    [Route("Admin/[controller]")]
    [ApiController]
    public class ReportedCommentController : ControllerBase
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<Comment> _commentRepository;

        public ReportedCommentController(PRN231_V2Context context)
        {
            _context = context;
            _commentRepository = new GenericRepository<Comment>(_context);

        }

	
		[HttpGet("GetAllReportedComment")]
        public async Task<IActionResult> GetAllReportedComments()
        {
            var allRepComment = await _context.ReportedComments.Include(x=>x.UserReport).Include(x => x.UserComment).Include(x => x.Comment).ToListAsync();
            if (allRepComment != null && allRepComment.Any())
            {
                var result = allRepComment.Select(x => new
                {
                    x.ReportedCommentId,
                    x.CommentId,
                    x.Comment.Content,
                    x.UserCommentId,
                    x.UserReportId,
                    x.DateTime,
                    x.ReasonReport,
                    x.Comment.Status,
                    x.UserReport.UserName,
                    x.UserComment.Email


                });
                return Ok(result);
            }
            else
            {
                return NotFound("No users found");
            }

        }

		
		[HttpPut("UpdateCommnentStatus/{id}")]
        public async Task<IActionResult> UpdateCommentStatus(int id, [FromBody] string status)
        {
          

            if (ModelState.IsValid)
            {
                // Check if the course with the given ID exists
                Comment existingcomment = await _commentRepository.GetByIdAsync(id);

                if (existingcomment == null)
                {
                    return NotFound("Course not found");
                }

                // Update the course's status
                existingcomment.Status = status;

                try
                {
                    // Save changes to the database
                    await _context.SaveChangesAsync();
                    return Ok(existingcomment);
                }
                catch (DbUpdateException ex)
                {
                    // Handle exceptions if any
                    return StatusCode(500, $"Failed to update course status: {ex.Message}");
                }
            }
            else
            {
                return BadRequest(ModelState);
            }
        }
    }
}

