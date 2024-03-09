using Backend.Models;
using Backend.Repositories;

namespace Backend.Services.Implement
{
    public class OrderDetailServiceImpl : IOrderDetailService
    {
        IGenericRepository<OrderDetail> _orderDetailRepository = new GenericRepository<OrderDetail>(new PRN231_V2Context());
        public async Task<IEnumerable<OrderDetail>> GetOrderDetailsOfStudentAsync(int userId)
        {
            return await _orderDetailRepository.GetListByConditionAsync(x => x.UserId == userId);
        }
    }
}
