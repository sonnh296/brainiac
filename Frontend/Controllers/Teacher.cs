using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers {
    public class Teacher : Controller {
        public IActionResult Index() {
            return View();
        }

        public IActionResult DashBoard()
        {
            return View("DashBoard");
        }
    }
}
