using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers {
    public class TeacherCourseDetail : Controller {
        public IActionResult Index() {
            return View("Views/Teacher/CourseDetail/Index.cshtml");
        }
    }
}
