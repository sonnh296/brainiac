namespace Backend.Auth.Requests
{
    public class ResetPassRequest
    {
        public int UserId { get; set; }
        public string? Email { get; set; }
        public string Password { get; set; }
    }
}
