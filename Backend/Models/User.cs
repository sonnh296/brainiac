using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Backend.Models
{
    public partial class User
    {
        public User()
        {
            Comments = new HashSet<Comment>();
            OrderDetails = new HashSet<OrderDetail>();
            Ratings = new HashSet<Rating>();
            ReportedCommentUserComments = new HashSet<ReportedComment>();
            ReportedCommentUserReports = new HashSet<ReportedComment>();
            ResourceUsers = new HashSet<ResourceUser>();
            UserCourses = new HashSet<UserCourse>();
            UserTests = new HashSet<UserTest>();
        }

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public int? RoleId { get; set; }
        public decimal? Balance { get; set; }

        public virtual Role Role { get; set; }
        [JsonIgnore]
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        [JsonIgnore]
        public virtual ICollection<Rating> Ratings { get; set; }
        public virtual ICollection<ReportedComment> ReportedCommentUserComments { get; set; }
        public virtual ICollection<ReportedComment> ReportedCommentUserReports { get; set; }
        public virtual ICollection<ResourceUser> ResourceUsers { get; set; }
        public virtual ICollection<UserCourse> UserCourses { get; set; }
        public virtual ICollection<UserTest> UserTests { get; set; }
    }
}
