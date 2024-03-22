namespace Backend.DTOs
{
    public class AnswerCreateDTO
    {
        public string? Content { get; set; }
        public int? QuestionId { get; set; }
        public bool? IsCorrect { get; set; }
    }
}
