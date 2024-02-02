using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers
{
    public class WeatherForecast : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
