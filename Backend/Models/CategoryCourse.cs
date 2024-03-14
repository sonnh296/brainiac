using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class CategoryCourse
    {
        public int CategoryCourseId { get; set; }
        public int? CategoryId { get; set; }
        public int? CourseId { get; set; }

        public virtual Category? Category { get; set; }
        public virtual Course? Course { get; set; }
    }
}
