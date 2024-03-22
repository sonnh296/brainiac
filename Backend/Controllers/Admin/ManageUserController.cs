using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace Backend.Controllers.Admin
{
    [Route("Admin/[controller]")]
    [ApiController]
    public class ManageUserController : Controller
    {
        private readonly PRN231_V2Context _context;
        private readonly IGenericRepository<User> _userRepository;
        private readonly IGenericRepository<Role> _roleRepository;
        public ManageUserController(PRN231_V2Context context)
        {
            _context = context;
            _userRepository = new GenericRepository<User>(_context);
            _roleRepository = new GenericRepository<Role>(_context);
		}
		// GET: Admin/ManageUser/{id}
		[Authorize(Roles = "Admin")]
		[HttpGet("GetUser/{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            var user = await _context.Users
                .Where(x => x.UserId == id)
                .Select(x => new
                {
                    x.UserId,
                    x.UserName,
                    x.Email,
                    x.Balance,
                    x.Role.RoleName,
                    x.IsActive

                })
              .FirstOrDefaultAsync();
            if (user != null)
            {

                return Ok(user);
            }
            else
            {
                return NotFound();
            }
        }
		// GET: Admin/ManageUser/GetAllUsers
		[Authorize(Roles = "Admin")]
		[HttpGet("GetAllUsers")]
        public async Task<IActionResult> GetAllUsers(string? searchText)
        {
            // Lấy danh sách người dùng
            var query =  _context.Users
                .Include(u => u.Role)
                .Select(u => new
                {
                    u.UserId,
                    u.UserName,
                    u.Email,
                    u.IsActive,
                    u.Balance,
                    Role = new
                    {
                        u.Role.RoleId,
                        u.Role.RoleName
                    }
                    // Thêm các thuộc tính khác từ bảng User và Role nếu cần
                });  // Kết hợp thông tin từ bảng Role
            if (!string.IsNullOrEmpty(searchText))
            {
                query = query.Where(x => x.UserName.Contains(searchText) || x.Email.Contains(searchText));
            }
            var AllUsers = await query.ToListAsync();
            if(AllUsers !=null && AllUsers.Any())
            {
                return Ok(AllUsers);
            }
            else
            {
                return NotFound("No users found");
            }


            // Tạo một danh sách mới chứa thông tin người dùng và vai trò (nếu có)



        }

		// GET: Admin/ManageUser/GetUsersByRole/{roleId}
		[Authorize(Roles = "Admin")]
		[HttpGet("GetUsersByRole/{roleId}")]
        public async Task<IActionResult> GetUsersByRole(int roleId)
        {
            Role role = await _roleRepository.GetByIdAsync(roleId);

            if (role != null)
            {
                // Lấy danh sách người dùng thuộc vai trò
                IEnumerable<User> users = await _userRepository.GetListByConditionAsync(u => u.RoleId == roleId);
                return Ok(users);
            }
            else
            {
                return NotFound("Role not found");
            }
        }

		// POST: Admin/ManageUser/AddUser
		[Authorize(Roles = "Admin")]
		[HttpPost("AddUser")]
        public async Task<IActionResult> AddUser([FromBody] User newUser)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra xem vai trò có tồn tại không
                Role role = await _roleRepository.GetByIdAsync(newUser.RoleId ?? 0);

                if (role == null)
                {
                    return BadRequest("Invalid RoleId");
                }

                // Thêm người dùng vào cơ sở dữ liệu
                 _userRepository.Add(newUser);
                return Ok(newUser);
            }
            else
            {
                return BadRequest(ModelState);
            }
        }

		// PUT: Admin/ManageUser/UpdateUser/{id}
		[Authorize(Roles = "Admin")]
		[HttpPut("UpdateUser/{id}")]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] User updatedUser)
        {
            if (id != updatedUser.UserId)
            {
                return BadRequest("Invalid UserId");
            }

            if (ModelState.IsValid)
            {
                // Kiểm tra xem người dùng có tồn tại không
                User existingUser = await _userRepository.GetByIdAsync(id);

                if (existingUser == null)
                {
                    return NotFound("User not found");
                }

                // Cập nhật thông tin người dùng trong cơ sở dữ liệu
                _userRepository.Add(updatedUser);
                return Ok(updatedUser);
            }
            else
            {
                return BadRequest(ModelState);
            }
        }

		// DELETE: Admin/ManageUser/DeleteUser/{id}
		[Authorize(Roles = "Admin")]
		[HttpDelete("DeleteUser/{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            User user = await _userRepository.GetByIdAsync(id);

            if (user != null)
            {
                // Xóa người dùng khỏi cơ sở dữ liệu
                 _userRepository.Delete(user);
                return Ok(user);
            }
            else
            {
                return NotFound("User not found");
            }
        }

		[Authorize(Roles = "Admin")]
		[HttpPut("UpdateUserStatus/{id}")]
        public async Task<IActionResult> UpdateStatus(int id, [FromBody] int status)
        {
           

            if (ModelState.IsValid)
            {
                // Check if the course with the given ID exists
                User existingUser = await _userRepository.GetByIdAsync(id);

                if (existingUser == null)
                {
                    return NotFound("User not found");
                }

                // Update the course's status
                if(status == 1)
                {                    
                    existingUser.IsActive = true;
                }else if (status == 0) {
                    existingUser.IsActive = false;
                }
                else
                {
                    return BadRequest();
                }

                

                try
                {
                    // Save changes to the database
                    await _context.SaveChangesAsync();
                    return Ok(existingUser);
                }
                catch (DbUpdateException ex)
                {
                    // Handle exceptions if any
                    return StatusCode(500, $"Failed to update user status: {ex.Message}");
                }
            }
            else
            {
                return BadRequest(ModelState);
            }
        }

    }
}
