using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Admin
{
    public class AdminController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult DashBoard()
        {
            return View("DashBoard");
        }
        public IActionResult ManageCourse()
        {
            return View("managecourse");
        }
        public IActionResult Login()
        {
            return View("Login");
        }
        public IActionResult ManageAccount()
        {
            return View("manageaccount");
        }
        public IActionResult ReportedComment()
        {
            return View("reportedcomment");
        }
       
         public IActionResult DetailComment()
        {
            return View("detailcomment");
        }
        public IActionResult DetailAccount()
        {
            return View("detailaccount");
        }
    }
}
