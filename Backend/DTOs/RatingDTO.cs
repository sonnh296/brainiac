namespace Backend.DTOs
{
    public class RatingDTO
    {
        public int? RatingId { get; set; }
        public int? UserId { get; set; }
        public int? CourseId { get; set; }
        public int? Point { get; set; }
    }
}
