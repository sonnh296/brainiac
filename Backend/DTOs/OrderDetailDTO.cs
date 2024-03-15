namespace Backend.DTOs
{
    public class OrderDetailDTO
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public int? CourseId { get; set; }
        public DateTime Date { get; set; }
        public decimal? Total { get; set; }
    }
}
