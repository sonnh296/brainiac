using Backend.DTOs;
using Backend.DTOs.Auth;
using Backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using NuGet.Common;
using System.Composition;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Backend.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase {
        private IConfiguration _configuration;
        public LoginController(IConfiguration configuration) {
            _configuration = configuration;
        }

        User _user = new User();
        private string reftk = "";
        private DateTime exprs = DateTime.MinValue;

        private User Authenticate(LoginRequest loginRequest) {
            if(loginRequest != null) {
                var _context = new PRN231_V2Context();
                var user = _context.Users.Include(u => u.Role)
                    .FirstOrDefault(u => u.UserName == loginRequest.UserName && u.Password==loginRequest.Password);

                if (user != null) {
                    _user.UserName = user.UserName;
                    _user.Password = user.Password;
                    return user;
                }
            }
            return null;
        }

        private String GenerateToken(User user) {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[] {
                new Claim(ClaimTypes.Role, user.Role.RoleName),
                new Claim("ID", user.UserId + ""),
            };

            var token = new JwtSecurityToken(_configuration["Jwt:Issuer"], _configuration["Jwt:Audience"], claims,
                expires:DateTime.Now.AddMinutes(10080),
                signingCredentials: credentials
                );


            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private RefreshToken GetRefreshToken() {
            var refreshToken = new RefreshToken() {
                Token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(32)),
                Expires = DateTime.Now.AddDays(2),
                Created = DateTime.Now
            };

            return refreshToken;
        }

        private void SetRefreshToken(RefreshToken newRefreshToken) {
            var cookieOptions = new CookieOptions {
                HttpOnly = true,
                Expires = newRefreshToken.Expires
            };

            Response.Cookies.Append("refreshToken", newRefreshToken.Token, cookieOptions);

            reftk = newRefreshToken.Token;
            exprs = newRefreshToken.Expires;
        }

        [HttpPost("refresh-token")]
        public async Task<ActionResult<string>> RefreshToken() {
            var refreshToken = Request.Cookies["refreshToken"];

            if(!reftk.Equals(refreshToken)) {
                return Unauthorized("Invalid refresh token");
            }else if(exprs < DateTime.Now) {
                return Unauthorized("Token exprierd");
            }

            string token = GenerateToken(_user);
            var newRefreshToken = GetRefreshToken();
            SetRefreshToken(newRefreshToken);

            return Ok( token);
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<ActionResult<LoginResponse>> Login(LoginRequest loginRequest) {

            var user = Authenticate(loginRequest);

            if (user != null) {
                var token = GenerateToken(user);
                return Ok(new LoginResponse {
                    id = user.UserId,
                    Role = user.Role.RoleName,
                    Token = token,
                    Error = ""
                });
            }

            var refreshToken = GetRefreshToken();
            SetRefreshToken(refreshToken);

            return Ok(new LoginResponse {
                Error = "Wrong username or passworrd"
            });
        }
    }
}
