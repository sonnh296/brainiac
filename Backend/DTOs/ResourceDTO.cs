namespace Backend.DTOs
{
    public class ResourceDTO
    {
        public int ResourceId { get; set; }
        public string Content { get; set; }
        public string Description { get; set; }
        public int? CourseId { get; set; }
        public bool? IsFree { get; set; }
        public int? OrdinalNumber { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public int? Status { get; set; }
    }
}
