using Frontend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Net.Mail;
using System.Net;

namespace Frontend.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }
        public IActionResult Login()
        {
            return View("Login");
        }
        public IActionResult Search()
        {
            return View("Search");
        }
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult WaitSendMail(int userId)
        {
            SendEmail(userId);
            return View();
        }

        private void SendEmail(int userId)
        {
            string from = "tronghoa267762@gmail.com";
            string to = "doibuon777@gmail.com";
            string subject = "Brainiac-Password Reset Request";
            string password = "qhtlxekfcwkdqpzt";

            string htmlBody = $@"
<!DOCTYPE html>
<html lang=""en"">
<head>
    <meta charset=""UTF-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
    <title>Password Reset</title>
    <style>
        /* Reset styles */
        body, html {{
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }}
        /* Container styles */
        .container {{
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }}
        /* Heading styles */
        h1 {{
            font-size: 24px;
            text-align: center;
            color: #333;
        }}
        /* Paragraph styles */
        p {{
            margin-bottom: 20px;
            color: #666;
        }}
        /* Button styles */
        .btn {{
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }}
        /* Footer styles */
        .footer {{
            margin-top: 20px;
            text-align: center;
            color: #999;
        }}
    </style>
</head>
<body>
    <div class=""container"">
        <h1>Brainiac-Password Reset</h1>
        <p>Hello,</p>
        <p>We received a request to reset your password. If you did not make this request, you can ignore this email.</p>
        <p>To reset your password, please click the button below:</p>
        <p><a href=""http://localhost:5016/Home/Resetpassword?userId={userId}"" class=""btn"">Reset Password</a></p>
        <p>If you have any questions or need assistance, please contact our support team.</p>
        <p>Thank you,</p>
        <p>The Support Team</p>
        <div class=""footer"">
            <p>This is an automated message. Please do not reply.</p>
        </div>
    </div>
</body>
</html>
";
            MailMessage message = new MailMessage(from, to, subject, htmlBody);
            message.IsBodyHtml = true;
            message.BodyEncoding = System.Text.Encoding.UTF8;
            message.SubjectEncoding = System.Text.Encoding.UTF8;

            message.ReplyToList.Add(new MailAddress(from));
            using var smtpClient = new SmtpClient("smtp.gmail.com");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Credentials = new NetworkCredential(from, password);
            try
            {
                smtpClient.Send(message);
            }
            catch (Exception ex)
            {
            }
        }


        public IActionResult ResetPassword(int userId)
        {
            return View();
        }
    }
}