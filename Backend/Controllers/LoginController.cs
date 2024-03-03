using Backend.DTOs;
using Backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Backend.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase {
        private IConfiguration _configuration;
        public LoginController(IConfiguration configuration) {
            _configuration = configuration;
        }

        private User Authenticate(LoginRequest loginRequest) {
            if(loginRequest != null) {
                var _context = new PRN231_V2Context();
                var user = _context.Users.Include(u => u.Role)
                    .FirstOrDefault(u => u.UserName == loginRequest.UserName && u.Password==loginRequest.Password);

                if(user != null) {
                    return user;
                }
            }
            return null;
        }

        private String GenerateToken(User user) {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[] {
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, user.Role.RoleName),
            };

            var token = new JwtSecurityToken(_configuration["Jwt:Issuer"], _configuration["Jwt:Audience"], claims,
                expires:DateTime.Now.AddMinutes(120),
                signingCredentials: credentials
                );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        [AllowAnonymous]
        [HttpPost]
        public IActionResult Login(LoginRequest loginRequest) {
            IActionResult response = Unauthorized();
            var user = Authenticate(loginRequest);

            if (user != null) {
                var token = GenerateToken(user);
                response = Ok(new {token = token});
            }

            return response;
        }
    }
}
