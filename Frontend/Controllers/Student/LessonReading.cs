using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class LessonReading : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/LessonReading.cshtml");
        }
    }
}
