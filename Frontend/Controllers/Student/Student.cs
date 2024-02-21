using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class Student : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
