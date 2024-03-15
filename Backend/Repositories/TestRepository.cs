using System;
using Backend.Models;

namespace Backend.Repositories
{
	public class TestRepository: ITestRepository
    {
        private readonly PRN231_V2Context _context = new PRN231_V2Context();

        public TestRepository(PRN231_V2Context context)
        {
            _context = context;
        }
        public void Create(Test test)
        {
            _context.Tests.Add(test);
            _context.SaveChanges();
        }

        public void Delete(Test test)
        {
            _context.Tests.Remove(test);
            _context.SaveChanges();
        }

        public IEnumerable<Test> GetAll()
        {
            return _context.Tests.ToList();
        }

        public List<Test> GetByCourseId(int courseid)
        {
            return _context.Tests.Where(x => x.CourseId == courseid).ToList();

        }

        public Test GetById(int id)
        {
            return _context.Tests.FirstOrDefault(x => x.TestId == id);
        }

        public void Update(Test test)
        {
            _context.Tests.Update(test);
            _context.SaveChanges();
        }
    }
}

