namespace Frontend.Models
{
    public class PaymentInformationModel
    {
        public int UserId { get; set; }
        public decimal Amount { get; set; }
        public DateTime CreatedDate { get; set; }
        public int? CourseId { get; set; }
    }
}
