using Frontend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Frontend.Controllers {
    public class HomePageController : Controller {
        private readonly ILogger<HomeController> _logger;

        public HomePageController(ILogger<HomeController> logger) {
            _logger = logger;
        }

        public IActionResult Index() {
            return View();
        }

       
    }
}