namespace Backend.DTOs.Resource
{
    public class ResourceCreateDTO
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Description { get; set; }
        public string Content { get; set; }
        public bool? IsFree { get; set; }
        public int? Status { get; set; }    
    }
}
