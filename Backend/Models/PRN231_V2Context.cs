using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace Backend.Models
{
    public partial class PRN231_V2Context : DbContext
    {
        public PRN231_V2Context()
        {
        }

        public PRN231_V2Context(DbContextOptions<PRN231_V2Context> options)
            : base(options)
        {
        }

        public virtual DbSet<Answer> Answers { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<CategoryCourse> CategoryCourses { get; set; } = null!;
        public virtual DbSet<Comment> Comments { get; set; } = null!;
        public virtual DbSet<Course> Courses { get; set; } = null!;
        public virtual DbSet<OrderDetail> OrderDetails { get; set; } = null!;
        public virtual DbSet<Question> Questions { get; set; } = null!;
        public virtual DbSet<Rating> Ratings { get; set; } = null!;
        public virtual DbSet<ReportedComment> ReportedComments { get; set; } = null!;
        public virtual DbSet<Resource> Resources { get; set; } = null!;
        public virtual DbSet<ResourceUser> ResourceUsers { get; set; } = null!;
        public virtual DbSet<Role> Roles { get; set; } = null!;
        public virtual DbSet<Test> Tests { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<UserCourse> UserCourses { get; set; } = null!;
        public virtual DbSet<UserTest> UserTests { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("server =brainiac.database.windows.net; database = PRN231_V2;uid=brainiac;pwd=Admin1234@; Encrypt=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Answer>(entity =>
            {
                entity.ToTable("Answer");

                entity.HasOne(d => d.Question)
                    .WithMany(p => p.Answers)
                    .HasForeignKey(d => d.QuestionId)
                    .HasConstraintName("FK_Answer_Question");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");

                entity.Property(e => e.CategoryName).HasMaxLength(255);
            });

            modelBuilder.Entity<CategoryCourse>(entity =>
            {
                entity.ToTable("CategoryCourse");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.CategoryCourses)
                    .HasForeignKey(d => d.CategoryId)
                    .HasConstraintName("FK_CategoryCourse_Category");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.CategoryCourses)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_CategoryCourse_Course");
            });

            modelBuilder.Entity<Comment>(entity =>
            {
                entity.ToTable("Comment");

                entity.Property(e => e.CommentDate).HasColumnType("datetime");

                entity.Property(e => e.Status).HasMaxLength(50);

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Comments)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_Comment_Course");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Comments)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_Comment_User");
            });

            modelBuilder.Entity<Course>(entity =>
            {
                entity.ToTable("Course");

                entity.Property(e => e.CourseName).HasMaxLength(255);

                entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");

                entity.Property(e => e.Status).HasMaxLength(50);

                entity.Property(e => e.Title).HasMaxLength(255);
            });

            modelBuilder.Entity<OrderDetail>(entity =>
            {
                entity.HasKey(e => e.OrderId);

                entity.ToTable("OrderDetail");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.Total).HasColumnType("money");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.CourseId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_OrderDetail_Course");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_OrderDetail_User");
            });

            modelBuilder.Entity<Question>(entity =>
            {
                entity.ToTable("Question");

                entity.HasOne(d => d.Test)
                    .WithMany(p => p.Questions)
                    .HasForeignKey(d => d.TestId)
                    .HasConstraintName("FK_Question_Test");
            });

            modelBuilder.Entity<Rating>(entity =>
            {
                entity.ToTable("Rating");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_Rating_Course");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Ratings)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_Rating_User");
            });

            modelBuilder.Entity<ReportedComment>(entity =>
            {
                entity.ToTable("ReportedComment");

                entity.Property(e => e.DateTime).HasColumnType("datetime");

                entity.Property(e => e.ReasonReport).IsUnicode(false);

                entity.HasOne(d => d.Comment)
                    .WithMany(p => p.ReportedComments)
                    .HasForeignKey(d => d.CommentId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReportedComment_Comment");

                entity.HasOne(d => d.UserComment)
                    .WithMany(p => p.ReportedCommentUserComments)
                    .HasForeignKey(d => d.UserCommentId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReportedComment_UserComment");

                entity.HasOne(d => d.UserReport)
                    .WithMany(p => p.ReportedCommentUserReports)
                    .HasForeignKey(d => d.UserReportId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReportedComment_UserReport");
            });

            modelBuilder.Entity<Resource>(entity =>
            {
                entity.ToTable("Resource");

                entity.Property(e => e.Description).HasMaxLength(255);

                entity.Property(e => e.Type).HasMaxLength(50);

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Resources)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_Resource_Course");
            });

            modelBuilder.Entity<ResourceUser>(entity =>
            {
                entity.ToTable("ResourceUser");

                entity.HasOne(d => d.Resource)
                    .WithMany(p => p.ResourceUsers)
                    .HasForeignKey(d => d.ResourceId)
                    .HasConstraintName("FK_ResourceUser_Resource");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.ResourceUsers)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_ResourceUser_User");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("Role");

                entity.Property(e => e.RoleName).HasMaxLength(255);
            });

            modelBuilder.Entity<Test>(entity =>
            {
                entity.ToTable("Test");

                entity.Property(e => e.PercentPoint).HasColumnType("decimal(5, 2)");

                entity.Property(e => e.Status).HasMaxLength(50);

                entity.Property(e => e.TestName).HasMaxLength(255);

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Tests)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_Test_Course");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.Property(e => e.Balance).HasColumnType("money");

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.Password).HasMaxLength(255);

                entity.Property(e => e.UserName).HasMaxLength(255);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("FK_User_Role");
            });

            modelBuilder.Entity<UserCourse>(entity =>
            {
                entity.ToTable("UserCourse");

                entity.Property(e => e.Status).HasMaxLength(50);

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.UserCourses)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_UserCourse_Course");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserCourses)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_UserCourse_User");
            });

            modelBuilder.Entity<UserTest>(entity =>
            {
                entity.ToTable("UserTest");

                entity.Property(e => e.TestDate).HasColumnType("datetime");

                entity.HasOne(d => d.Test)
                    .WithMany(p => p.UserTests)
                    .HasForeignKey(d => d.TestId)
                    .HasConstraintName("FK_UserTest_Test");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserTests)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK_UserTest_User");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
