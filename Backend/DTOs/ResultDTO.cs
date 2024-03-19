
namespace Backend.DTOs
{
    public class ResultDTO
    {
        public int UserId { get; set; }
        public int TestId { get; set; }
        public DateTime TestDate { get; set; }
        public int NumberQuestion { get; set; }
        public double  TimeDoTest { get; set; }
        public List<List<AnswerDTO>> Answers { get; set; }
    }

    public class AnswerDTO
    {
        public int QuestionId { get; set; }
        public int AnswerId { get; set; }
    }
}
