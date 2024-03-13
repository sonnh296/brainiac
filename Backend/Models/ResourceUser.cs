using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class ResourceUser
    {
        public int ResourceUserId { get; set; }
        public int? ResourceId { get; set; }
        public int? UserId { get; set; }
        public bool? IsComplete { get; set; }

        public virtual Resource? Resource { get; set; }
        public virtual User? User { get; set; }
    }
}
