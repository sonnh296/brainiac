using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class LessonVideo : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/LessonVideo.cshtml");
        }
    }
}
