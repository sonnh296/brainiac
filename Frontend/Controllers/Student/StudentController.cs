using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class StudentController : Controller
    {
        public IActionResult CourseDetail()
        {
            return View("Views/Student/CourseDetail.cshtml");
        }
    }
}
