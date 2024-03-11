﻿using Backend.Models;
using Backend.Services;
using Backend.Services.Implement;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : Controller
    {
        private readonly PRN231_V2Context _context;
        public UserController(PRN231_V2Context context)
        {
            _context = context;
        }
        [HttpGet("CurrentUser")]
        public async Task<IActionResult> GetCurrentUserAsyn()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = -1;
            if (identity != null)
            {
                IEnumerable<Claim> claims = identity.Claims;
                // or
                userID = Int32.Parse(identity.FindFirst("ID").Value);
            }
            var user = await _context.Users
                .Include(u => u.Role)
                .FirstOrDefaultAsync(u => u.UserId == userID);
            var obj = new
            {
                UserId = user.UserId,
                UserName = user.UserName,
                Email = user.Email,
                Role = user.Role.RoleName,
                Balance = user.Balance,
            };
            return Ok(obj);
        }
    }
}
