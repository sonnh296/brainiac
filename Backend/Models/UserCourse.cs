using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class UserCourse
    {
        public int UserCourseId { get; set; }
        public int? UserId { get; set; }
        public int? CourseId { get; set; }
        public bool? IsStudent { get; set; }
        public string? Status { get; set; }

        public virtual Course? Course { get; set; }
        public virtual User? User { get; set; }
    }
}
