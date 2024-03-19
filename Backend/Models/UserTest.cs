using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class UserTest
    {
        public int UserTestId { get; set; }
        public int? TestId { get; set; }
        public int? UserId { get; set; }
        public double? Point { get; set; }
        public DateTime? TestDate { get; set; }
        public double? TotalTime { get; set; }

        public virtual Test? Test { get; set; }
        public virtual User? User { get; set; }
    }
}
