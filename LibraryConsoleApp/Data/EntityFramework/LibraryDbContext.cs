using Microsoft.EntityFrameworkCore;
using LibraryConsoleApp.Models;
using LibraryConsoleApp.Configuration;

namespace LibraryConsoleApp.Data.EntityFramework
{
    /// <summary>
    /// Контекст базы данных для Entity Framework
    /// </summary>
    public class LibraryDbContext : DbContext
    {
        public DbSet<Book> Books { get; set; }
        public DbSet<Reader> Readers { get; set; }

        public LibraryDbContext()
        {
        }

        /// <summary>
        /// Метод настройки контекста
        /// </summary>
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var connectionString = ConfigurationReader.GetConnectionString();
                optionsBuilder.UseSqlServer(connectionString);
            }
        }

        /// <summary>
        /// Метод настройки моделей
        /// </summary>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Book>(entity =>
            {
                entity.ToTable("Books");

                entity.HasKey(b => b.BookId);
                entity.Property(b => b.BookId)
                    .HasColumnName("BookID");

                entity.Property(b => b.Title)
                    .HasColumnName("Title")
                    .HasMaxLength(200)
                    .IsRequired(); 

                entity.Property(b => b.Author)
                    .HasColumnName("Author")
                    .HasMaxLength(150)
                    .IsRequired();

                entity.Property(b => b.ISBN)
                    .HasColumnName("ISBN")
                    .HasMaxLength(20)
                    .IsRequired();

                entity.Property(b => b.PublishYear)
                    .HasColumnName("PublishYear");

                entity.Property(b => b.IsAvailable)
                    .HasColumnName("IsAvailable");

                entity.Property(b => b.AddedDate)
                    .HasColumnName("AddedDate");
            });

            modelBuilder.Entity<Reader>(entity =>
            {
                entity.ToTable("Readers");
                entity.HasKey(r => r.ReaderId);

                entity.Property(r => r.ReaderId)
                    .HasColumnName("ReaderID");

                entity.Property(r => r.FirstName)
                    .HasColumnName("FirstName")
                    .HasMaxLength(50)
                    .IsRequired();

                entity.Property(r => r.LastName)
                    .HasColumnName("LastName")
                    .HasMaxLength(50)
                    .IsRequired();

                entity.Property(r => r.LibraryCardNumber)
                    .HasColumnName("LibraryCardNumber")
                    .HasMaxLength(20)
                    .IsRequired();

                entity.Property(r => r.Phone)
                    .HasColumnName("Phone")
                    .HasMaxLength(20);

                entity.Property(r => r.RegistrationDate)
                    .HasColumnName("RegistrationDate");

                entity.Property(r => r.IsActive)
                    .HasColumnName("IsActive");
            });

            base.OnModelCreating(modelBuilder);
        }
    }
}