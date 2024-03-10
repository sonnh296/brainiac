using System;
using System.Collections.Generic;

namespace Backend.Models
{
    public partial class Resource
    {
        public Resource()
        {
            ResourceUsers = new HashSet<ResourceUser>();
        }

        public int ResourceId { get; set; }
        public string? Content { get; set; }
        public string? Description { get; set; }
        public int? CourseId { get; set; }
        public bool? IsFree { get; set; }
        public int? OrdinalNumber { get; set; }
        public string Type { get; set; } = null!;
        public string? Name { get; set; }

        public virtual Course? Course { get; set; }
        public virtual ICollection<ResourceUser> ResourceUsers { get; set; }
    }
}
