using Microsoft.Data.SqlClient;
using LibraryConsoleApp.Models;
using LibraryConsoleApp.Interfaces;

namespace LibraryConsoleApp.Data.AdoNet
{
    /// <summary>
    /// Репозиторий для работы с книгами через ADO.NET
    /// </summary>
    public class BookRepository : IBookRepository
    {
        private readonly string _connectionString;

        public BookRepository()
        {
            _connectionString = Configuration.ConfigurationReader.GetConnectionString();
        }

        /// <summary>
        /// Получить все книги из базы данных
        /// </summary>
        public List<Book> GetAll()
        {
            var books = new List<Book>();

            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                const string sql = @"
                    SELECT BookID, Title, Author, ISBN, PublishYear, IsAvailable, AddedDate 
                    FROM Books";

                using (var command = new SqlCommand(sql, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var book = new Book
                            {
                                BookId = reader.GetGuid(reader.GetOrdinal("BookID")),
                                Title = reader.GetString(reader.GetOrdinal("Title")),
                                Author = reader.GetString(reader.GetOrdinal("Author")),
                                ISBN = reader.GetString(reader.GetOrdinal("ISBN")),
                                PublishYear = reader.IsDBNull(reader.GetOrdinal("PublishYear"))
                                    ? (int?)null
                                    : reader.GetInt32(reader.GetOrdinal("PublishYear")),
                                IsAvailable = reader.GetBoolean(reader.GetOrdinal("IsAvailable")),
                                AddedDate = reader.GetDateTime(reader.GetOrdinal("AddedDate"))
                            };
                            books.Add(book);
                        }
                    }
                }
            }
            return books;
        }

        /// <summary>
        /// Получить одну книгу по ID
        /// </summary>
        public Book GetById(Guid bookId)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                const string sql = @"
                    SELECT BookID, Title, Author, ISBN, PublishYear, IsAvailable, AddedDate 
                    FROM Books 
                    WHERE BookID = @BookId";

                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@BookId", bookId);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Book
                            {
                                BookId = reader.GetGuid(reader.GetOrdinal("BookID")),
                                Title = reader.GetString(reader.GetOrdinal("Title")),
                                Author = reader.GetString(reader.GetOrdinal("Author")),
                                ISBN = reader.GetString(reader.GetOrdinal("ISBN")),
                                PublishYear = reader.IsDBNull(reader.GetOrdinal("PublishYear"))
                                    ? null
                                    : reader.GetInt32(reader.GetOrdinal("PublishYear")),
                                IsAvailable = reader.GetBoolean(reader.GetOrdinal("IsAvailable")),
                                AddedDate = reader.GetDateTime(reader.GetOrdinal("AddedDate"))
                            };
                        }
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Добавить новую книгу в базу данных
        /// </summary>
        public void Add(Book book)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                const string sql = @"
                    INSERT INTO Books (Title, Author, ISBN, PublishYear, IsAvailable)
                    VALUES (@Title, @Author, @ISBN, @PublishYear, @IsAvailable)";

                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@Title", book.Title);
                    command.Parameters.AddWithValue("@Author", book.Author);
                    command.Parameters.AddWithValue("@ISBN", book.ISBN);

                    command.Parameters.AddWithValue("@PublishYear",
                        (object)book.PublishYear ?? DBNull.Value);

                    command.Parameters.AddWithValue("@IsAvailable", book.IsAvailable);

                    int rowsAffected = command.ExecuteNonQuery();
                    Console.WriteLine($"[ADO.NET] Добавлено строк: {rowsAffected}");
                }
            }
        }

        /// <summary>
        /// Обновить информацию о книге
        /// </summary>
        public void Update(Book book)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                const string sql = @"
                    UPDATE Books 
                    SET Title = @Title, 
                        Author = @Author, 
                        ISBN = @ISBN, 
                        PublishYear = @PublishYear, 
                        IsAvailable = @IsAvailable
                    WHERE BookID = @BookId";

                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@Title", book.Title);
                    command.Parameters.AddWithValue("@Author", book.Author);
                    command.Parameters.AddWithValue("@ISBN", book.ISBN);
                    command.Parameters.AddWithValue("@PublishYear",
                        (object)book.PublishYear ?? DBNull.Value);
                    command.Parameters.AddWithValue("@IsAvailable", book.IsAvailable);
                    command.Parameters.AddWithValue("@BookId", book.BookId);

                    int rowsAffected = command.ExecuteNonQuery();
                    Console.WriteLine($"[ADO.NET] Обновлено строк: {rowsAffected}");
                }
            }
        }

        /// <summary>
        /// Удалить книгу из базы данных
        /// </summary>
        public void Delete(Guid bookId)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                const string sql = "DELETE FROM Books WHERE BookID = @BookId";

                using (var command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@BookId", bookId);

                    int rowsAffected = command.ExecuteNonQuery();
                    Console.WriteLine($"[ADO.NET] Удалено строк: {rowsAffected}");
                }
            }
        }
    }
}