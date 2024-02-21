using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class TakingExam : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/TakingExam.cshtml");
        }
    }
}
