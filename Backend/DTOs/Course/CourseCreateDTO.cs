namespace Backend.DTOs.Course
{
    public class CourseCreateDTO
    {
        public string? CourseName { get; set; }
        public string? Title { get; set; }
        public decimal Price { get; set; }
        public List<CategoryDTO> Categories { get; set; }
    }
}
