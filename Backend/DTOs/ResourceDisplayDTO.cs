namespace Backend.DTOs
{
    public class ResourceDisplayDTO
    {
        public int ResourceId { get; set; }
        public string? Description { get; set; }
        public int? CourseId { get; set; }
        public bool? IsFree { get; set; }
        public int? OrdinalNumber { get; set; }
    }
}
