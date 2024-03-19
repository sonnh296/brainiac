namespace Backend.DTOs.Auth {
    public class LoginResponse {
        public int id { get; set; }
        public string Role { get; set; }
        public string Token { get; set; }
        public string RefreshToken { get; set; }
		public string Error { get; set; }


    }
}
