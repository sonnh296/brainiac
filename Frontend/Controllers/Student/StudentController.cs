using Frontend.Models;
using Frontend.Services;
using Microsoft.AspNetCore.Mvc;

namespace Frontend.Controllers.Student
{
    public class StudentController : Controller
    {
        IVnPayService _vnPayService;
        public StudentController(IVnPayService vnPayService)
        {
            _vnPayService = vnPayService;
        }
        public IActionResult CourseDetail(string courseId)
        {
            return View();
        }
        public IActionResult CategoryCourse(string categoryId) {
            return View();
        }
        public IActionResult TeacherCourse(string teacherId)
        {
            return View();
        }
        public IActionResult Course(string courseId)
        {
            return View();
        }
        public IActionResult Payment(string courseId)
        {
            return View();
        }
        public IActionResult CreatePaymentUrl(int userId, decimal amount, bool isCheckout, int courseId)
        {
            var urlSuccess = $"http://localhost:5016/Student/SuccessPayment?userId={userId}&courseId={courseId}&amount={amount}";
            
            var url =_vnPayService.CreatePaymentUrl(new PaymentInformationModel
            {
                Amount = amount,
                CreatedDate = DateTime.Now,
                UserId = userId,
                CourseId = courseId
            }, HttpContext, urlSuccess);
            return Redirect(url);
        }
        public IActionResult SuccessPayment(int userId, int? courseId, decimal amount)
        {
            return View();
        }
        public IActionResult HistoryPay(int userId)
        {
            return View();
        }
    }
}
