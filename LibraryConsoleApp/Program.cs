using LibraryConsoleApp.Interfaces;
using LibraryConsoleApp.Data.AdoNet;
using LibraryConsoleApp.Data.EntityFramework;
using LibraryConsoleApp.Models;

Console.Clear();
Console.WriteLine("Консольная утилита для работы с БД");
Console.WriteLine();
Console.WriteLine("Выберите способ работы с базой данных:");
Console.WriteLine("  1. ADO.NET ");
Console.WriteLine("  2. Entity Framework ");
Console.WriteLine();
Console.Write("Ваш выбор (1 или 2): ");

string choice = Console.ReadLine();

bool useAdoNet = choice == "1";
string modeName = useAdoNet ? "ADO.NET" : "Entity Framework";

IBookRepository repository;

if (useAdoNet)
{
    repository = new BookRepository();
}
else
{
    repository = new BookRepositoryEf();
}

Console.Clear();
Console.WriteLine($"Режим работы: {modeName}");
Console.WriteLine("Нажмите любую клавишу для начала...");
Console.ReadKey();



Console.Clear();
Console.WriteLine($"[{modeName}] Все книги из БД");
Console.WriteLine();

var books = repository.GetAll();

if (books.Count == 0)
{
    Console.WriteLine("В базе данных нет книг.");
}
else
{
    Console.WriteLine($"Найдено книг: {books.Count}");
    Console.WriteLine();
    foreach (var book in books)
    {
        Console.WriteLine($"  {book}");
    }
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();

Console.Clear();
Console.WriteLine($"[{modeName}] Вывод одной книги по ID");
Console.WriteLine();

Book foundBook = null;

if (books.Count > 0)
{
    var firstBookId = books[0].BookId;
    Console.WriteLine($"Книга с ID: {firstBookId}");
    Console.WriteLine();

    foundBook = repository.GetById(firstBookId); 

    if (foundBook != null)
    {
        Console.WriteLine("Книга найдена:");
        Console.WriteLine($"  {foundBook}");
    }
    else
    {
        Console.WriteLine("Книга не найдена.");
    }
}
else
{
    Console.WriteLine("Нет книг для поиска.");
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();


Console.Clear();
Console.WriteLine($"[{modeName}] Добавить новую книгу");
Console.WriteLine();

var newBook = new Book
{
    Title = "Мастер и Маргарита",
    Author = "Михаил Булгаков",
    ISBN = "978-5-17-090999-X",
    PublishYear = 1967,
    IsAvailable = true
};

Console.WriteLine("Создаем книгу:");
Console.WriteLine($"  Название: {newBook.Title}");
Console.WriteLine($"  Автор: {newBook.Author}");
Console.WriteLine($"  ISBN: {newBook.ISBN}");
Console.WriteLine($"  Год: {newBook.PublishYear}");
Console.WriteLine($"  Доступна: {(newBook.IsAvailable ? "Да" : "Нет")}");
Console.WriteLine();

repository.Add(newBook); 

Console.WriteLine();
Console.WriteLine($"Книга успешно добавлена в базу данных ({modeName})!");

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();


Console.Clear();
Console.WriteLine($"[{modeName}] Список книг после добавления");
Console.WriteLine();

books = repository.GetAll();  

Console.WriteLine($"Теперь в базе {books.Count} книг:");
Console.WriteLine();
foreach (var book in books)
{
    Console.WriteLine($"  {book}");
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();


Console.Clear();
Console.WriteLine($"[{modeName}] Обновление информации о книге");
Console.WriteLine();

var bookToUpdate = books.FirstOrDefault(b => b.Title == "Мастер и Маргарита");

if (bookToUpdate != null)
{
    Console.WriteLine("Книга ДО обновления:");
    Console.WriteLine($"  {bookToUpdate}");
    Console.WriteLine();

    bookToUpdate.Title = "Мастер и Маргарита (2-е издание)";
    bookToUpdate.PublishYear = 1973;
    bookToUpdate.IsAvailable = false;

    Console.WriteLine("Книга ПОСЛЕ обновления:");
    Console.WriteLine($"  Название: {bookToUpdate.Title}");
    Console.WriteLine($"  Год: {bookToUpdate.PublishYear}");
    Console.WriteLine($"  Доступна: {(bookToUpdate.IsAvailable ? "Да" : "Нет")}");
    Console.WriteLine();

    repository.Update(bookToUpdate); 

    Console.WriteLine($"Книга успешно обновлена в базе данных ({modeName})!");
}
else
{
    Console.WriteLine("Книга для обновления не найдена.");
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();

Console.Clear();
Console.WriteLine($"[{modeName}] Проверка изменений в базе данных");
Console.WriteLine();

if (bookToUpdate != null)
{
    var updatedBook = repository.GetById(bookToUpdate.BookId);  

    if (updatedBook != null)
    {
        Console.WriteLine("Обновленные данные в БД:");
        Console.WriteLine($"  {updatedBook}");
    }
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();


Console.Clear();
Console.WriteLine($"[{modeName}] Удалить книгу из базы данных");
Console.WriteLine();

if (bookToUpdate != null)
{
    Console.WriteLine($"Удаляем книгу: {bookToUpdate.Title}");
    Console.WriteLine($"   ID: {bookToUpdate.BookId}");
    Console.WriteLine();

    repository.Delete(bookToUpdate.BookId); 

    Console.WriteLine($"Книга успешно удалена из базы данных ({modeName})!");
}

Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для продолжения...");
Console.ReadKey();


Console.Clear();
Console.WriteLine($"[{modeName}] Финальный список книг");
Console.WriteLine();

books = repository.GetAll(); 

Console.WriteLine($"Итого книг в базе: {books.Count}");
Console.WriteLine();
foreach (var book in books)
{
    Console.WriteLine($"  {book}");
}

Console.WriteLine();
Console.WriteLine($"Программа завершена (режим: {modeName})");
Console.WriteLine();
Console.WriteLine("Нажмите любую клавишу для выхода...");
Console.ReadKey();