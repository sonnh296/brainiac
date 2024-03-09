using Backend.Models;

namespace Backend.Services
{
    public interface IOrderDetailService
    {
        Task<IEnumerable<OrderDetail>> GetOrderDetailsOfStudentAsync(int userId);
    }
}
