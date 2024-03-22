using Backend.DTOs;
using Backend.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Security.Claims;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : BaseApiController
    {
        private readonly PRN231_V2Context _context;
        public TestController(PRN231_V2Context context)
		{
            _context = context;
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("Course/{courseId}")]
        public async Task<IActionResult> GetTestOfCourseAsync(int courseId)
        {
            var tests = _context.Tests.Where(x => x.CourseId == courseId)
                .OrderBy(x => x.TestId)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.TestName
                });
            if (tests == null)
            {
                return NoContent();
            }
            return Ok(tests);
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("HistoryTest/{testId}")]
        public async Task<IActionResult> HistoryTestlAsync(int testId)
        {
            //var identity = HttpContext.User.Identity as ClaimsIdentity;
            int userID = UserID;
            //if (identity != null)
            //{
            //    IEnumerable<Claim> claims = identity.Claims;
            //    // or
            //    userID = Int32.Parse(identity.FindFirst("ID").Value);
            //}
            var test = _context.UserTests
                .Include(x => x.Test)
                .Where(x => x.TestId == testId && x.UserId == userID)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.Test.TestName,
                    TimeDoTest = x.TotalTime,
                    Point = x.Point,
                    TestDate = x.TestDate
                })
                .OrderByDescending(x => x.TestDate);
            if (test == null)
            {
                return NotFound();
            }
            return Ok(test);
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("TestDetail/{testId}")]
        public async Task<IActionResult> GetTestDetailAsync(int testId)
        {
            var test = _context.Tests
                .Include(x => x.Questions)
                .Select(x => new
                {
                    TestId = x.TestId,
                    TestName = x.TestName,
                    Time = x.Time,
                    PercentPoint = x.PercentPoint,
                    NumberQuestion = x.Questions.Count(),
                    CourseId = x.CourseId
                })
                .FirstOrDefault(x => x.TestId == testId);
            if (test == null)
            {
                return NotFound();
            }
            return Ok(test);
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpGet("Question/{testId}")]
        public async Task<IActionResult> GetQuestionOfTestAsync(int testId)
        {
            var questions = _context.Questions
                .Include(x => x.Answers)
                .Where(x => x.TestId == testId)
                .Select(x => new
                {
                    QuestionId = x.QuestionId,
                    QuestionContent = x.Content,
                    Answers = x.Answers.Select(x => new
                    {
                        AnswerId = x.AnswerId,
                        AnswerContent = x.Content,
                        IsTrue = x.IsCorrect
                    })
                });
            if (questions == null)
            {
                return NoContent();
            }
            return Ok(questions);
        }

		[Authorize(Roles = "Teacher, Student, Admin")]
		[HttpPost("SubmitTest")]
        public async Task<IActionResult> SubmitTestAsync([FromBody] ResultDTO result)
        {
            DateTime testDate = result.TestDate;
            double timeDoTest = result.TimeDoTest;
            int point = 0;
            int userID = result.UserId;
            int testID = result.TestId;
            int numberOfQuestion = result.NumberQuestion;

            int correctAnswer = 0;
            for(int i = 0; i < result.Answers.Count; i++)
            {
                var listQuestion = result.Answers[i].Select(x => x.QuestionId).Distinct();
                foreach (var item in listQuestion)
                {
                    var question = _context.Questions
                        .FirstOrDefault(x => x.QuestionId == item);
                    var answers = result.Answers[i]
                        .Where(x => x.QuestionId == item)
                        .Select(x => x.AnswerId);
                    if (question != null && AreAnswersCorrect(answers, item))
                    {
                        correctAnswer++;
                    }
                }
            }

            var test = _context.Tests
                .Include(x => x.Questions)
                .FirstOrDefault(x => x.TestId == testID);

            var userTest = new UserTest
            {
                UserId = userID,
                TestId = testID,
                TestDate = testDate,
                TotalTime = timeDoTest,
                Point = (double?)(correctAnswer * test.PercentPoint / numberOfQuestion)
            };

            var obj = new
            {
                UserId = userID,
                TestId = testID,
                TestDate = testDate,
                TotalTime = timeDoTest,
                Point = (double?)(correctAnswer * test.PercentPoint / numberOfQuestion),
                NumberCorrectAnswer = correctAnswer,
                CourseId = test.CourseId
            };

            _context.UserTests.Add(userTest);
            await _context.SaveChangesAsync();
            return Ok(obj);
        }

        private bool AreAnswersCorrect(IEnumerable<int> answers, int questionId)
        {
            var correctAnswers = _context.Answers
            .Where(x => x.QuestionId == questionId && x.IsCorrect == true)
            .Select(x => x.AnswerId)
            .ToList();
            if (answers.Count() != correctAnswers.Count)
            {
                return false;
            }
            foreach (var item in answers)
            {
                if (!correctAnswers.Contains(item))
                {
                    return false;
                }
            }
            return true;
        }
    }
}
