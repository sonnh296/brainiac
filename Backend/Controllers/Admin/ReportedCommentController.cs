using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers.Admin
{
    [Route("Admin/[controller]")]
    [ApiController]
    public class ReportedCommentController : ControllerBase
    {
        private readonly PRN231_V2Context _context;


        public ReportedCommentController(PRN231_V2Context context)
        {
            _context = context;

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
    }
}

