using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Comment
    {
        public Comment()
        {
            ReportedComments = new HashSet<ReportedComment>();
        }

        public int CommentId { get; set; }
        public int? UserId { get; set; }
        public int? CourseId { get; set; }
        public string Content { get; set; }
        public DateTime? CommentDate { get; set; }
        public string Status { get; set; }

        public virtual Course Course { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<ReportedComment> ReportedComments { get; set; }
    }
}
