using System.Linq.Expressions;

namespace Backend.Repositories
{
    public interface IGenericRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAllAsync();
        Task<T> GetByIdAsync(object id);
        Task<IEnumerable<T>> GetListByConditionAsync(Expression<Func<T, bool>> condition);
        void Add(T obj);
        void Update(T obj);
        void Delete(object id);
        Task SaveAsync();
    }
}
