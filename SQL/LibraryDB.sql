CREATE DATABASE LibraryDB;
Go
USE LibraryDB;
Go

-- Категории книг
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1), 
    CategoryName NVARCHAR(100) NOT NULL,      
    Description NVARCHAR(200)
);

-- Книги
CREATE TABLE Books (
    BookID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
    Title NVARCHAR(200) NOT NULL,
    Author NVARCHAR(150) NOT NULL,
    ISBN NVARCHAR(20) NOT NULL,
    PublishYear INT,
    IsAvailable BIT DEFAULT 1,      
    AddedDate DATETIME2 DEFAULT GETDATE() 
);

-- Уникальный индекс для поля ISBN
CREATE UNIQUE INDEX UQ_Books_ISBN ON Books(ISBN);

-- Читатели
CREATE TABLE Readers (
    ReaderID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    LibraryCardNumber NVARCHAR(20) NOT NULL,
    Phone NVARCHAR(20),
    RegistrationDate DATE DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Уникальный индекс для номера читательского билета 
CREATE UNIQUE INDEX UQ_Readers_LibraryCardNumber ON Readers(LibraryCardNumber);

-- Промежуточная таблица
CREATE TABLE BookCategories (
    BookID UNIQUEIDENTIFIER NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Выдача книг
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY IDENTITY(1,1),
    BookID UNIQUEIDENTIFIER NOT NULL,
    ReaderID INT NOT NULL,
    LoanDate DATETIME2 DEFAULT GETDATE(),
    DueDate DATETIME2 NOT NULL,
    ReturnDate DATETIME2, 
    IsReturned BIT DEFAULT 0,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
);

-- Штрафы
CREATE TABLE Fines (
    FineID INT PRIMARY KEY IDENTITY(1,1),
    LoanID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL, 
    IssueDate DATE DEFAULT GETDATE(),
    IsPaid BIT DEFAULT 0,
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

-- Заполнение
INSERT INTO Categories (CategoryName, Description) VALUES
('Фантастика', 'Научная фантастика и фэнтези'),
('Детективы', 'Криминальные истории и расследования'),
('Классика', 'Классическая литература'),
('Наука', 'Научно-популярные книги'),
('Приключения', 'Приключенческие романы');

INSERT INTO Books (Title, Author, ISBN, PublishYear, IsAvailable) VALUES
('Гарри Поттер и философский камень', 'Джоан Роулинг', '978-5-699-12345-6', 1997, 1),
('Преступление и наказание', 'Федор Достоевский', '978-5-699-23456-7', 1866, 1),
('Война и мир', 'Лев Толстой', '978-5-699-34567-8', 1869, 0), -- Книга выдана
('Краткая история времени', 'Стивен Хокинг', '978-5-699-45678-9', 1988, 1),
('Властелин колец', 'Джон Толкин', '978-5-699-56789-0', 1954, 1),
('Шерлок Холмс', 'Артур Конан Дойл', '978-5-699-67890-1', 1892, 0), -- Книга выдана
('1984', 'Джордж Оруэлл', '978-5-699-78901-2', 1949, 1),
('Мастер и Маргарита', 'Михаил Булгаков', '978-5-699-89012-3', 1967, 1);

INSERT INTO Readers (FirstName, LastName, LibraryCardNumber, Phone, IsActive) VALUES
('Анна', 'Иванова', 'LIB-2025-001', '+7 (999) 111-11-11', 1),
('Петр', 'Сидоров', 'LIB-2025-002', '+7 (999) 222-22-22', 1),
('Мария', 'Петрова', 'LIB-2025-003', '+7 (999) 333-33-33', 1),
('Иван', 'Смирнов', 'LIB-2025-004', '+7 (999) 444-44-44', 0), -- Заблокирован
('Елена', 'Козлова', 'LIB-2025-005', '+7 (999) 555-55-55', 1);

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Гарри Поттер и философский камень' AND c.CategoryName = 'Фантастика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Гарри Поттер и философский камень' AND c.CategoryName = 'Приключения';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Преступление и наказание' AND c.CategoryName = 'Классика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Преступление и наказание' AND c.CategoryName = 'Детективы';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Война и мир' AND c.CategoryName = 'Классика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Краткая история времени' AND c.CategoryName = 'Наука';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Властелин колец' AND c.CategoryName = 'Фантастика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Властелин колец' AND c.CategoryName = 'Приключения';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Шерлок Холмс' AND c.CategoryName = 'Детективы';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Шерлок Холмс' AND c.CategoryName = 'Приключения';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = '1984' AND c.CategoryName = 'Фантастика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = '1984' AND c.CategoryName = 'Классика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Мастер и Маргарита' AND c.CategoryName = 'Классика';

INSERT INTO BookCategories (BookID, CategoryID)
SELECT b.BookID, c.CategoryID 
FROM Books b, Categories c 
WHERE b.Title = 'Мастер и Маргарита' AND c.CategoryName = 'Фантастика';

INSERT INTO Loans (BookID, ReaderID, LoanDate, DueDate, IsReturned)
SELECT b.BookID, r.ReaderID, DATEADD(day, -10, GETDATE()), DATEADD(day, 4, GETDATE()), 0
FROM Books b, Readers r
WHERE b.Title = 'Гарри Поттер и философский камень' AND r.FirstName = 'Анна';

INSERT INTO Loans (BookID, ReaderID, LoanDate, DueDate, ReturnDate, IsReturned)
SELECT b.BookID, r.ReaderID, DATEADD(day, -20, GETDATE()), DATEADD(day, -6, GETDATE()), NULL, 0
FROM Books b, Readers r
WHERE b.Title = 'Война и мир' AND r.FirstName = 'Петр';

INSERT INTO Loans (BookID, ReaderID, LoanDate, DueDate, ReturnDate, IsReturned)
SELECT b.BookID, r.ReaderID, DATEADD(day, -5, GETDATE()), DATEADD(day, 9, GETDATE()), DATEADD(day, -2, GETDATE()), 1
FROM Books b, Readers r
WHERE b.Title = 'Шерлок Холмс' AND r.FirstName = 'Мария';

INSERT INTO Loans (BookID, ReaderID, LoanDate, DueDate, IsReturned)
SELECT b.BookID, r.ReaderID, DATEADD(day, -1, GETDATE()), DATEADD(day, 13, GETDATE()), 0
FROM Books b, Readers r
WHERE b.Title = 'Краткая история времени' AND r.FirstName = 'Елена';


INSERT INTO Fines (LoanID, Amount, IsPaid)
SELECT l.LoanID, 60.00, 0
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Readers r ON l.ReaderID = r.ReaderID
WHERE b.Title = 'Война и мир' AND r.FirstName = 'Петр';

INSERT INTO Fines (LoanID, Amount, IsPaid)
SELECT l.LoanID, 500.00, 1
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Readers r ON l.ReaderID = r.ReaderID
WHERE b.Title = 'Шерлок Холмс' AND r.FirstName = 'Мария';

-- Запросы
-- Все доступные книги, выпущенные после 1950 года, отсортировать по году по возрастанию
SELECT Title, Author, PublishYear 
FROM Books 
WHERE IsAvailable = 1 AND PublishYear > 1950
ORDER BY PublishYear ASC;

-- Обновить
UPDATE Books SET IsAvailable = 0 WHERE Title = '1984';

-- Удалить
DELETE FROM Fines WHERE IsPaid = 1;

-- Выборка с группировкой
SELECT c.CategoryName, COUNT(bc.BookID) AS BookCount
FROM Categories c
JOIN BookCategories bc ON c.CategoryID = bc.CategoryID
GROUP BY c.CategoryName;

-- Левое соединение
SELECT r.FirstName, r.LastName, l.LoanDate, b.Title
FROM Readers r
LEFT JOIN Loans l ON r.ReaderID = l.ReaderID
LEFT JOIN Books b ON l.BookID = b.BookID;

-- Правое соединение
SELECT c.CategoryName AS 'Категория', b.Title AS 'Название книги'
FROM BookCategories bc
RIGHT JOIN Categories c ON bc.CategoryID = c.CategoryID 
LEFT JOIN Books b ON bc.BookID = b.BookID; 

-- Пересечение
-- Все книги в категории "Фантастика"
SELECT b.Title
FROM Books b
JOIN BookCategories bc ON b.BookID = bc.BookID
JOIN Categories c ON bc.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Фантастика'

INTERSECT

-- Все книги в категории "Приключения"
SELECT b.Title
FROM Books b
JOIN BookCategories bc ON b.BookID = bc.BookID
JOIN Categories c ON bc.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Приключения';
