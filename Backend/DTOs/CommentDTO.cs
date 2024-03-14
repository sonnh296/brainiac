namespace Backend.DTOs
{
    public class CommentDTO
    {
        public int? CommentId { get; set; }
        public int? UserCommentId { get; set; }
        public int? UserReportId { get; set; }
        public int? CourseId { get; set; }
        public string Content { get; set; }
    }
}
