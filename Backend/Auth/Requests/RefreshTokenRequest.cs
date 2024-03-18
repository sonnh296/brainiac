namespace Backend.Auth.Requests {
    public class RefreshTokenRequest {
        public int UserId { get; set; }
        public string RefreshToken { get; set; }
    }
}
