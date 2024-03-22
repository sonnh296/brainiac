namespace Backend.DTOs.Resource
{
    public class ResourceUpdateDTO
    {
        public int ResourceId { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Content { get; set; }
        public string Description { get; set; }
        public bool? IsFree { get; set; }
    }
}
