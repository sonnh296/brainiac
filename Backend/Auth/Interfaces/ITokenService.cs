using Backend.Auth.Requests;
using Backend.Auth.Responses;
using Backend.Models;

namespace Backend.Auth.Interfaces {
    public interface ITokenService {
        Task<Tuple<string, string>> GenerateTokensAsync(int userId);
        Task<ValidateRefreshTokenResponse> ValidateRefreshTokenAsync(RefreshTokenRequest refreshTokenRequest);
        Task<bool> RemoveRefreshTokenAsync(User user);
    }
}
