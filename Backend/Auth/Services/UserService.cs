using Backend.Auth.Helpers;
using Backend.Auth.Interfaces;
using Backend.Auth.Requests;
using Backend.Auth.Responses;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Auth.Services {
    public class UserService : IUserService{
        private readonly PRN231_V2Context _context;
        private readonly ITokenService tokenService;
        public UserService(PRN231_V2Context _context, ITokenService tokenService) {
            this._context = _context;
            this.tokenService = tokenService;
        }
        public async Task<TokenResponse> LoginAsync(LoginRequest loginRequest) {
            var user = _context.Users.Include(u => u.Role).SingleOrDefault(user => user.Email == loginRequest.Email);
            if (user == null) {
                return new TokenResponse {
                    Success = false,
                    Error = "Email not found",
                    ErrorCode = "L02"
                };
            }
            var passwordHash = PasswordHelper.HashUsingPbkdf2(loginRequest.Password, Convert.FromBase64String(user.PasswordSalt));
            if (user.Password != passwordHash) {
                return new TokenResponse {
                    Success = false,
                    Error = "Invalid Password",
                    ErrorCode = "L03"
                };
            }
            var token = await System.Threading.Tasks.Task.Run(() => tokenService.GenerateTokensAsync(user.UserId));
            return new TokenResponse {
                Success = true,
                AccessToken = token.Item1,
                RefreshToken = token.Item2,
                Role = user.Role.RoleName,
            };
        }
        public async Task<LogoutResponse> LogoutAsync(int userId) {
            var refreshToken = await _context.RefreshTokens.FirstOrDefaultAsync(o => o.UserId == userId);
            if (refreshToken == null) {
                return new LogoutResponse { Success = true };
            }
            _context.RefreshTokens.Remove(refreshToken);
            var saveResponse = await _context.SaveChangesAsync();
            if (saveResponse >= 0) {
                return new LogoutResponse { Success = true };
            }
            return new LogoutResponse { Success = false, Error = "Unable to logout user", ErrorCode = "L04" };
        }
        public async Task<SignupResponse> SignupAsync(SignUpRequest signupRequest) {
            var existingUser = await _context.Users.SingleOrDefaultAsync(user => user.Email == signupRequest.Email);
            if (existingUser != null) {
                return new SignupResponse {
                    Success = false,
                    Error = "User already exists with the same email",
                    ErrorCode = "S02"
                };
            }
            if (signupRequest.Password.Length ==0) {
                return new SignupResponse {
                    Success = false,
                    Error = "Password and confirm password do not match",
                    ErrorCode = "S03"
                };
            }
            if (signupRequest.Password.Length <= 7) // This can be more complicated than only length, you can check on alphanumeric and or special characters
            {
                return new SignupResponse {
                    Success = false,
                    Error = "Password is weak",
                    ErrorCode = "S04"
                };
            }
            var salt = PasswordHelper.GetSecureSalt();
            var passwordHash = PasswordHelper.HashUsingPbkdf2(signupRequest.Password, salt);
            var user = new User {
                Email = signupRequest.Email,
                Password = passwordHash,
                PasswordSalt = Convert.ToBase64String(salt),
                UserName = signupRequest.UserName,
                Balance = 0,
                RoleId = signupRequest.RoleId,
                //Ts = signupRequest.Ts,
                IsActive = true // You can save is false and send confirmation email to the user, then once the user confirms the email you can make it true
            };
            await _context.Users.AddAsync(user);
            var saveResponse = await _context.SaveChangesAsync();
            if (saveResponse >= 0) {
                return new SignupResponse { Success = true, Email = user.Email };
            }
            return new SignupResponse {
                Success = false,
                Error = "Unable to save the user",
                ErrorCode = "S05"
            };
        }
    }
}
