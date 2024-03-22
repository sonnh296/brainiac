using Backend.Models;

namespace Backend.DTOs.Test
{
    public class TestCreateDTO
    {
        public string TestName { get; set; } = null!;
        public int? Time { get; set; }
        public decimal? PercentPoint { get; set; }
        public int? CourseId { get; set; }
        public string Status { get; set; } = null!;
        public virtual ICollection<QuestionCreateDTO> Questions { get; set; }
        public virtual ICollection<AnswerCreateDTO> Answers { get; set; }
    }
}
