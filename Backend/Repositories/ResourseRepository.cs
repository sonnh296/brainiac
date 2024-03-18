using Backend.Models;

namespace Backend.Repositories
{
    public class ResourseRepository: IResourceRepository
    {
        private readonly PRN231_V2Context _context = new PRN231_V2Context();

        public ResourseRepository(PRN231_V2Context context)
        {
            _context = context;
        }
        public void Create(Resource resource)
        {
            _context.Resources.Add(resource);
            _context.SaveChanges();
        }

        public void Delete(Resource resource)
        {
            _context.Resources.Remove(resource);
            _context.SaveChanges();
        }

        public IEnumerable<Resource> GetAll()
        {
            return _context.Resources.ToList();
        }
    
        public Resource GetById(int id)
        {
            return _context.Resources.FirstOrDefault(x => x.ResourceId == id);
        }
        public List<Resource> GetByResourceId(int courseid)
        {
            return _context.Resources.Where(x => x.CourseId == courseid).ToList();
        }

        public void Update(Resource resource)
        {
            _context.Resources.Update(resource);
            _context.SaveChanges();
        }
    }
}
