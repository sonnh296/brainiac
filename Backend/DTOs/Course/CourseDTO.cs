namespace Backend.DTOs.Course
{
    public class CourseDTO
    {
        public int CourseId { get; set; }
        public string? CourseName { get; set; }
        public string? Title { get; set; }
        public decimal Price { get; set; }
        public string? Status { get; set; }
        public List<CategoryDTO> Categories { get; set; }
        public List<ResourceDisplayDTO> Resources { get; set; }

    }
}
