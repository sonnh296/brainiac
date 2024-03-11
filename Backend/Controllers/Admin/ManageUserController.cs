using Backend.Models;
using Backend.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
        [HttpGet("GetUser/{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            User user = await _userRepository.GetByIdAsync(id);

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
        [HttpGet("GetAllUsers")]
        public async Task<IActionResult> GetAllUsers()
        {
            // Lấy danh sách người dùng
            var allUsers = await _context.Users
                .Include(u => u.Role) // Kết hợp thông tin từ bảng Role
                .ToListAsync();

            if (allUsers != null && allUsers.Any())
            {
                // Tạo một danh sách mới chứa thông tin người dùng và vai trò (nếu có)
                var result = allUsers.Select(u => new
                {
                    u.UserId,
                    u.UserName,
                    u.Email,
                    Role = new
                    {
                        u.Role?.RoleId,
                        u.Role?.RoleName
                    }
                    // Thêm các thuộc tính khác từ bảng User và Role nếu cần
                });

                return Ok(result);
            }
            else
            {
                return NotFound("No users found");
            }
        }

        // GET: Admin/ManageUser/GetUsersByRole/{roleId}
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

    }
}
