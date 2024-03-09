using Backend.Models;

namespace Backend.Services
{
    public interface IUserService
    {
        Task<User> GetUserByIdAsync(int id);
    }
}
