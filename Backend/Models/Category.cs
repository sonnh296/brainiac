using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Category
    {
        public Category()
        {
            CategoryCourses = new HashSet<CategoryCourse>();
        }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int? Status { get; set; }

        public virtual ICollection<CategoryCourse> CategoryCourses { get; set; }
    }
}
