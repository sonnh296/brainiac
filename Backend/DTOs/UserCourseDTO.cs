namespace Backend.DTOs
{
    public class UserCourseDTO
    {
        public int? UserId { get; set; }
        public int? CourseId { get; set; }
        public bool? IsStudent { get; set; }
        public string? Status { get; set; }
    }
}
