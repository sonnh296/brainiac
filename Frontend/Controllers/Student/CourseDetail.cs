using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class CourseDetail : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/CourseDetail.cshtml");
        }
    }
}
