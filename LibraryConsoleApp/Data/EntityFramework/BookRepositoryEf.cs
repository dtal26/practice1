using Microsoft.EntityFrameworkCore;
using LibraryConsoleApp.Models;
using LibraryConsoleApp.Interfaces;

namespace LibraryConsoleApp.Data.EntityFramework
{
    /// <summary>
    /// Репозиторий для работы с книгами через Entity Framework
    /// </summary>
    public class BookRepositoryEf : IBookRepository
    {
        /// <summary>
        /// Получить все книги
        /// </summary>
        public List<Book> GetAll()
        {
            using (var context = new LibraryDbContext())
            {
                return context.Books.ToList();
            }
        }

        /// <summary>
        /// Получить книгу по ID
        /// </summary>
        public Book GetById(Guid bookId)
        {
            using (var context = new LibraryDbContext())
            {
                return context.Books.FirstOrDefault(b => b.BookId == bookId);
            }
        }

        /// <summary>
        /// Добавить новую книгу
        /// </summary>
        public void Add(Book book)
        {
            using (var context = new LibraryDbContext())
            {
                context.Books.Add(book);
                context.SaveChanges();

                Console.WriteLine($"[EF] Книга добавлена с ID: {book.BookId}");
            }
        }

        /// <summary>
        /// Обновить книгу
        /// </summary>
        public void Update(Book book)
        {
            using (var context = new LibraryDbContext())
            {
                var existingBook = context.Books.FirstOrDefault(b => b.BookId == book.BookId);

                if (existingBook != null)
                {
                    existingBook.Title = book.Title;
                    existingBook.Author = book.Author;
                    existingBook.ISBN = book.ISBN;
                    existingBook.PublishYear = book.PublishYear;
                    existingBook.IsAvailable = book.IsAvailable;

                    context.SaveChanges();

                    Console.WriteLine($"[EF] Книга обновлена: {book.BookId}");
                }
            }
        }

        /// <summary>
        /// Удалить книгу
        /// </summary>
        public void Delete(Guid bookId)
        {
            using (var context = new LibraryDbContext())
            {
                var book = context.Books.FirstOrDefault(b => b.BookId == bookId);

                if (book != null)
                {
                    context.Books.Remove(book);
                    context.SaveChanges();

                    Console.WriteLine($"[EF] Книга удалена: {bookId}");
                }
            }
        }
    }
}