namespace Backend.Auth.Responses {
    public class TokenResponse : BaseResponse {
        public string? Role { get; set; }
        public string AccessToken { get; set; }
        public string RefreshToken { get; set; }
    }
}
