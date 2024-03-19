using System;
using Backend.Models;

namespace Backend.Repositories
{
    public interface ITestRepository
    {
        IEnumerable<Test> GetAll();
        Test GetById(int id);
        void Create(Test test);
        void Update(Test test);
        void Delete(Test test);
        List<Test> GetByCourseId(int courseid);
    }
}
