using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Answer
    {
        public int AnswerId { get; set; }
        public string? Content { get; set; }
        public int? QuestionId { get; set; }
        public bool? IsCorrect { get; set; }

        public virtual Question? Question { get; set; }
    }
}
