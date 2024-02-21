using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class ExamResult : Controller
    {
        public IActionResult Index()
        {
            return View("Views/Student/ExamResult.cshtml");
        }
    }
}
