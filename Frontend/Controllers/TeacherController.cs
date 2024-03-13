using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers
{
    public class TeacherController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult AddCourse()
        {
            return View();
        }
    }
}
