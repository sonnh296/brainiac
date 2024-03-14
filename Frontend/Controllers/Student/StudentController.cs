using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class StudentController : Controller
    {
        public IActionResult CourseDetail(string courseId)
        {
            return View();
        }
        public IActionResult CategoryCourse(string categoryId) {
            return View();
        }
        public IActionResult TeacherCourse(string teacherId)
        {
            return View();
        }
        public IActionResult Course(string courseId)
        {
            return View();
        }
        public IActionResult Payment(string courseId)
        {
            return View();
        }
    }
}
