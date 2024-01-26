using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class User
    {
        public User()
        {
            Comments = new HashSet<Comment>();
            Ratings = new HashSet<Rating>();
            ResourceUsers = new HashSet<ResourceUser>();
            UserCourses = new HashSet<UserCourse>();
            UserTests = new HashSet<UserTest>();
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public int? RoleId { get; set; }

        public virtual Role Role { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<Rating> Ratings { get; set; }
        public virtual ICollection<ResourceUser> ResourceUsers { get; set; }
        public virtual ICollection<UserCourse> UserCourses { get; set; }
        public virtual ICollection<UserTest> UserTests { get; set; }
    }
}
