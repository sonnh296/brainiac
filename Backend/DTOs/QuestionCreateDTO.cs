namespace Backend.DTOs
{
    public class QuestionCreateDTO
    {
        public int QuestionId { get; set; }
        public string? Content { get; set; }
        public int? TestId { get; set; }
    }
}
