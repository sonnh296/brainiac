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

        public IActionResult SingleCourseDetails(int? courseId)
        {
            if (courseId.HasValue)
            {
                ViewBag.CourseId = courseId;
                return View();
            }
            return View("/Views/Shared/Error.cshtml");
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
