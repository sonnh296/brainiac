using Backend.Auth.Requests;
using Backend.Auth.Responses;
using Backend.Models;

namespace Backend.Auth.Interfaces {
    public interface IUserService {
        Task<TokenResponse> LoginAsync(LoginRequest loginRequest);
        Task<SignupResponse> SignupAsync(SignUpRequest signupRequest);
        Task<LogoutResponse> LogoutAsync(int userId);
        Task<ResetPassRequest> ResetPassAsync(ResetPassRequest resetPassRequest);
        Task<User> FindUserAsync(string email);
    }
}
