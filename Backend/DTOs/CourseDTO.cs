namespace Backend.DTOs
{
    public class CourseDTO
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; } = null!;
        public string Title { get; set; } = null!;
        public decimal Price { get; set; }
        public string Status { get; set; } = null!;
    }
}
