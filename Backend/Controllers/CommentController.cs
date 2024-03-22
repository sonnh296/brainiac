using Backend.DTOs;
using Backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : Controller
    {
        private readonly PRN231_V2Context _context;
        public CommentController(PRN231_V2Context context)
		{
			_context = context;
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetCommentsOfCourseAsync(int courseId)
        {
            var comments = _context.Comments.Where(x => x.CourseId == courseId && x.Status == "1")
                .OrderByDescending(x => x.CommentDate)
                .Include(c => c.User);
            if(comments == null)
            {
                return NoContent();
            }
            return Ok(comments);
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpPost("ReportComment")]
        public async Task<IActionResult> ReportCommentAsync(CommentDTO comment)
        {
            try
            {
                ReportedComment rc = new ReportedComment
                {
                    CommentId = (int)comment.CommentId,
                    UserReportId = (int)comment.UserReportId,
                    UserCommentId = (int)comment.UserCommentId,
                    ReasonReport = comment.Content,
                    DateTime = DateTime.Now
                };
                _context.Add(rc);
                await _context.SaveChangesAsync();
                return Ok("Reported successfully. We will check later!!!");
            }
            catch (Exception)
            {
                return BadRequest("Report failed!!!");
            }
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpPost("PostComment")]
        public async Task<IActionResult> PostCommentAsync(CommentDTO comment)
        {
            try
            {
                Comment c = new Comment
                {
                    CourseId = comment.CourseId,
                    UserId = comment.UserCommentId,
                    Content = comment.Content,
                    CommentDate = DateTime.Now,
                    Status = "1"
                };
                _context.Add(c);
                await _context.SaveChangesAsync();
                return Ok("Posted successfully!!!");
            }
            catch (Exception)
            {
                return BadRequest("Post failed!!!");
            }
        }
    }
}
