using LibraryConsoleApp.Models;

namespace LibraryConsoleApp.Interfaces
{
    /// <summary>
    /// Интерфейс репозитория для работы с книгами
    /// </summary>
    public interface IBookRepository
    {
        /// <summary>
        /// Получить все книги из базы данных
        /// </summary>
        List<Book> GetAll();

        /// <summary>
        /// Получить одну книгу по ID
        /// </summary>
        Book GetById(Guid bookId);

        /// <summary>
        /// Добавить новую книгу в базу данных
        /// </summary>
        void Add(Book book);

        /// <summary>
        /// Обновить информацию о книге
        /// </summary>
        void Update(Book book);

        /// <summary>
        /// Удалить книгу из базы данных
        /// </summary>
        void Delete(Guid bookId);
    }
}