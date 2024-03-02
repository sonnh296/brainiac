using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Course
    {
        public Course()
        {
            CategoryCourses = new HashSet<CategoryCourse>();
            Comments = new HashSet<Comment>();
            OrderDetails = new HashSet<OrderDetail>();
            Ratings = new HashSet<Rating>();
            Resources = new HashSet<Resource>();
            Tests = new HashSet<Test>();
            UserCourses = new HashSet<UserCourse>();
        }

        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public string Title { get; set; }
        public decimal Price { get; set; }
        public string Status { get; set; }

        public virtual ICollection<CategoryCourse> CategoryCourses { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual ICollection<Rating> Ratings { get; set; }
        public virtual ICollection<Resource> Resources { get; set; }
        public virtual ICollection<Test> Tests { get; set; }
        public virtual ICollection<UserCourse> UserCourses { get; set; }
    }
}
