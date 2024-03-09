using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class UserServiceImpl : IUserService
    {
        IGenericRepository<User> _userRepository = new GenericRepository<User>(new PRN231_V2Context());
        public async Task<User> GetUserByIdAsync(int id)
        {
            return await _userRepository.GetByIdAsync(id);
        }
    }
}
