using Backend.Auth.Interfaces;
using Backend.Auth.Requests;
using Backend.Auth.Responses;
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
using System.Net.Mail;
using System.Net;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Backend.Controllers
{
    [Route("api/")]
    [ApiController]
    public class AuthController : BaseApiController
    {
        private readonly IUserService userService;
        private readonly ITokenService tokenService;
        public AuthController(IUserService userService, ITokenService tokenService)
        {
            this.userService = userService;
            this.tokenService = tokenService;
        }
        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login(LoginRequest loginRequest)
        {
            if (loginRequest == null || string.IsNullOrEmpty(loginRequest.Email) || string.IsNullOrEmpty(loginRequest.Password))
            {
                return BadRequest(new TokenResponse
                {
                    Error = "Missing login details",
                    ErrorCode = "L01"
                });
            }
            var loginResponse = await userService.LoginAsync(loginRequest);
            if (!loginResponse.Success)
            {
                return Unauthorized(new
                {
                    loginResponse.ErrorCode,
                    loginResponse.Error
                });
            }
            return Ok(loginResponse);
        }
        [HttpPost]
        [Route("refresh_token")]
        public async Task<IActionResult> RefreshToken(RefreshTokenRequest refreshTokenRequest)
        {
            if (refreshTokenRequest == null || string.IsNullOrEmpty(refreshTokenRequest.RefreshToken) || refreshTokenRequest.UserId == 0)
            {
                return BadRequest(new TokenResponse
                {
                    Error = "Missing refresh token details",
                    ErrorCode = "R01"
                });
            }
            var validateRefreshTokenResponse = await tokenService.ValidateRefreshTokenAsync(refreshTokenRequest);
            if (!validateRefreshTokenResponse.Success)
            {
                return UnprocessableEntity(validateRefreshTokenResponse);
            }
            var tokenResponse = await tokenService.GenerateTokensAsync(validateRefreshTokenResponse.UserId);
            return Ok(new { AccessToken = tokenResponse.Item1, Refreshtoken = tokenResponse.Item2 });
        }
        [HttpPost]
        [Route("signup")]
        public async Task<IActionResult> Signup(SignUpRequest signupRequest)
        {
            if (!ModelState.IsValid)
            {
                var errors = ModelState.Values.SelectMany(x => x.Errors.Select(c => c.ErrorMessage)).ToList();
                if (errors.Any())
                {
                    return BadRequest(new TokenResponse
                    {
                        Error = $"{string.Join(",", errors)}",
                        ErrorCode = "S01"
                    });
                }
            }

            var signupResponse = await userService.SignupAsync(signupRequest);
            if (!signupResponse.Success)
            {
                return UnprocessableEntity(signupResponse);
            }
            return Ok(signupResponse.Email);
        }
        [Authorize]
        [HttpPost]
        [Route("logout")]
        public async Task<IActionResult> Logout()
        {
            var logout = await userService.LogoutAsync(UserID);
            if (!logout.Success)
            {
                return UnprocessableEntity(logout);
            }
            return Ok();
        }

        [HttpPut]
        [Route("reset_password")]
        public async Task<IActionResult> ResetPassword(ResetPassRequest resetPasswordRequest)
        {
            try
            {
                var resetPasswordResponse = await userService.ResetPassAsync(resetPasswordRequest);
                return Ok(resetPasswordResponse);
            }
            catch (Exception)
            {
                return BadRequest();
                throw;
            }
        }

        [HttpGet]
        [Route("request_reset_pass/{email}")]
        public async Task<IActionResult> RequestResetPass(string email)
        {
            var user = await userService.FindUserAsync(email);
            if (user == null)
            {
                return BadRequest("Email not found");
            }
            else
            {
                SendEmail(email, user.UserId);
                return Ok("A email just sent you. Please check");
            }
        }

        private void SendEmail(string email, int userId)
        {
            string from = "tronghoa267762@gmail.com";
            string to = email;
            string subject = "Brainiac-Password Reset Request";
            string password = "qhtlxekfcwkdqpzt";

            string htmlBody = $@"
<!DOCTYPE html>
<html lang=""en"">
<head>
    <meta charset=""UTF-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
    <title>Password Reset</title>
    <style>
        /* Reset styles */
        body, html {{
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }}
        /* Container styles */
        .container {{
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }}
        /* Heading styles */
        h1 {{
            font-size: 24px;
            text-align: center;
            color: #333;
        }}
        /* Paragraph styles */
        p {{
            margin-bottom: 20px;
            color: #666;
        }}
        /* Button styles */
        .btn {{
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }}
        /* Footer styles */
        .footer {{
            margin-top: 20px;
            text-align: center;
            color: #999;
        }}
    </style>
</head>
<body>
    <div class=""container"">
        <h1>Brainiac-Password Reset</h1>
        <p>Hello,</p>
        <p>We received a request to reset your password. If you did not make this request, you can ignore this email.</p>
        <p>To reset your password, please click the button below:</p>
        <p><a href=""http://localhost:5016/Home/Resetpassword?userId={userId}"" class=""btn"">Reset Password</a></p>
        <p>If you have any questions or need assistance, please contact our support team.</p>
        <p>Thank you,</p>
        <p>The Support Team</p>
        <div class=""footer"">
            <p>This is an automated message. Please do not reply.</p>
        </div>
    </div>
</body>
</html>
";
            MailMessage message = new MailMessage(from, to, subject, htmlBody);
            message.IsBodyHtml = true;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.SubjectEncoding = System.Text.Encoding.UTF8;

            message.ReplyToList.Add(new MailAddress(from));
            using var smtpClient = new SmtpClient("smtp.gmail.com");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Credentials = new NetworkCredential(from, password);
            try
            {
                smtpClient.Send(message);
            }
            catch (Exception ex)
            {
            }
        }
    }
}
