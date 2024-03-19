using Frontend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace Frontend.Controllers {
    public class Home2Controller : Controller {
        private readonly ILogger<HomeController> _logger;

        public Home2Controller(ILogger<HomeController> logger) {
            _logger = logger;
        }

        public IActionResult Index() {
            return View();
        }

       
    }
}