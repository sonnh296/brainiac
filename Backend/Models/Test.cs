using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Test
    {
        public Test()
        {
            Questions = new HashSet<Question>();
            UserTests = new HashSet<UserTest>();
        }

        public int TestId { get; set; }
        public string TestName { get; set; } = null!;
        public int? Time { get; set; }
        public decimal? PercentPoint { get; set; }
        public int? CourseId { get; set; }
        public string Status { get; set; } = null!;

        public virtual Course? Course { get; set; }
        public virtual ICollection<Question> Questions { get; set; }
        public virtual ICollection<UserTest> UserTests { get; set; }
    }
}
