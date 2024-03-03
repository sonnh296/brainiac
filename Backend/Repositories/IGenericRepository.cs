namespace Backend.Repositories
{
    public interface IGenericRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAllAsync();
        Task<T> GetByIdAsync(object id);
        void Add(T obj);
        void Update(T obj);
        void Delete(object id);
        Task<T> GetByIdAsync();
    }
}
