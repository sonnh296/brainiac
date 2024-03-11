using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class ReportedComment
    {
        public int ReportedCommentId { get; set; }
        public int CommentId { get; set; }
        public int UserCommentId { get; set; }
        public int UserReportId { get; set; }
        public DateTime DateTime { get; set; }
        public string ReasonReport { get; set; }

        public virtual Comment Comment { get; set; }
        public virtual User UserComment { get; set; }
        public virtual User UserReport { get; set; }
    }
}
