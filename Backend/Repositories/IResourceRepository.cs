using Backend.Models;

namespace Backend.Repositories
{
   public interface  IResourceRepository
    {
        IEnumerable<Resource> GetAll();
        Resource GetById(int id);
        void Create(Resource resource);
        void Update(Resource resource);
        void Delete(Resource resource);
        List<Resource> GetByResourceId(int courseid);
    }
}
