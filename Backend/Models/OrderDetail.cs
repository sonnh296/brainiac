using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class OrderDetail
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public int CourseId { get; set; }
        public DateTime Date { get; set; }
        public string PaymentMethod { get; set; }

        public virtual Course Course { get; set; }
        public virtual User User { get; set; }
    }
}
