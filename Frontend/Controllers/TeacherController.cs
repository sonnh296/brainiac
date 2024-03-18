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
        public IActionResult DashBoard()
        {
            return View();
        }

        public IActionResult SingleCourseDetails()
        {
            return View();
        }

        public IActionResult AddResource(int? courseid)
        {
            if (courseid.HasValue)
            {
                ViewBag.CourseId = courseid;
                return View();
            }
            return View("/Views/Shared/Error.cshtml");
        }

    }
}
