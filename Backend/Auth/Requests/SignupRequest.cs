using System.ComponentModel.DataAnnotations;

namespace Backend.Auth.Requests {
    public class SignUpRequest {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        public string UserName { get; set; }
        [Required]
        public int RoleId { get; set; }
    }
}
