﻿using Backend.Auth.Interfaces;
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
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Backend.Controllers {
    [Route("api/")]
    [ApiController]
    public class AuthController : BaseApiController {
        private readonly IUserService userService;
        private readonly ITokenService tokenService;
        public AuthController(IUserService userService, ITokenService tokenService) {
            this.userService = userService;
            this.tokenService = tokenService;
        }
        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login(LoginRequest loginRequest) {
            if (loginRequest == null || string.IsNullOrEmpty(loginRequest.Email) || string.IsNullOrEmpty(loginRequest.Password)) {
                return BadRequest(new TokenResponse {
                    Error = "Missing login details",
                    ErrorCode = "L01"
                });
            }
            var loginResponse = await userService.LoginAsync(loginRequest);
            if (!loginResponse.Success) {
                return Unauthorized(new {
                    loginResponse.ErrorCode,
                    loginResponse.Error
                });
            }
            return Ok(loginResponse);
        }
        [HttpPost]
        [Route("refresh_token")]
        public async Task<IActionResult> RefreshToken(RefreshTokenRequest refreshTokenRequest) {
            if (refreshTokenRequest == null || string.IsNullOrEmpty(refreshTokenRequest.RefreshToken) || refreshTokenRequest.UserId == 0) {
                return BadRequest(new TokenResponse {
                    Error = "Missing refresh token details",
                    ErrorCode = "R01"
                });
            }
            var validateRefreshTokenResponse = await tokenService.ValidateRefreshTokenAsync(refreshTokenRequest);
            if (!validateRefreshTokenResponse.Success) {
                return UnprocessableEntity(validateRefreshTokenResponse);
            }
            var tokenResponse = await tokenService.GenerateTokensAsync(validateRefreshTokenResponse.UserId);
            return Ok(new { AccessToken = tokenResponse.Item1, Refreshtoken = tokenResponse.Item2 });
        }
        [HttpPost]
        [Route("signup")]
        public async Task<IActionResult> Signup(SignUpRequest signupRequest) {
            if (!ModelState.IsValid) {
                var errors = ModelState.Values.SelectMany(x => x.Errors.Select(c => c.ErrorMessage)).ToList();
                if (errors.Any()) {
                    return BadRequest(new TokenResponse {
                        Error = $"{string.Join(",", errors)}",
                        ErrorCode = "S01"
                    });
                }
            }

            var signupResponse = await userService.SignupAsync(signupRequest);
            if (!signupResponse.Success) {
                return UnprocessableEntity(signupResponse);
            }
            return Ok(signupResponse.Email);
        }
        [Authorize]
        [HttpPost]
        [Route("logout")]
        public async Task<IActionResult> Logout() {
            var logout = await userService.LogoutAsync(UserID);
            if (!logout.Success) {
                return UnprocessableEntity(logout);
            }
            return Ok();
        }
    }
}