using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class ListLesson : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/ListLesson.cshtml");
        }
    }
}
