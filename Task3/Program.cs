
public class Product
{
    private string _name;
    private string _manufacturer;
    private decimal _price;
    private DateTime _productionDate;
    private int _shelfLifeDays;

    public string Name
    {
        get => _name;
        set => _name = string.IsNullOrWhiteSpace(value)
            ? throw new ArgumentException("Наименование не может быть пустым")
            : value;
    }
    public string Manufacturer
    {
        get => _manufacturer;
        set => _manufacturer = string.IsNullOrWhiteSpace(value)
            ? throw new ArgumentException("Наименование производителя не может быть пустым")
            : value;
    }
    public decimal Price
    {
        get => _price;
        set => _price = value < 0
            ? throw new ArgumentException("Цена не может быть отрицательной")
            : value;
    }
    public DateTime ProductionDate
    {
        get => _productionDate;
        set => _productionDate = value > DateTime.Now
            ? throw new ArgumentException("Дата производства не может быть в будующем")
            : value;
    }
    public int ShelfLifeDays
    {
        get => _shelfLifeDays;
        set => _shelfLifeDays = value <= 0
            ? throw new ArgumentException("Срок годности должен быть положительным числом")
            : value;
    }

    public Product(string name, string manufacturer, decimal price, DateTime productionDate, int shelfLifeDays)
    {
        Name = name;
        Manufacturer = manufacturer;
        Price = price;
        ProductionDate = productionDate;
        ShelfLifeDays = shelfLifeDays;
    }

    public override string ToString()
    {
        DateTime expirationDate = ProductionDate.AddDays(ShelfLifeDays);
        return $"Название: {Name}\n " +
            $"Производитель: {Manufacturer}\n" +
            $"Цена: {Price:F2} руб.\n" +
            $"Дата производства: {ProductionDate:dd.MM.yyyy}\n" +
            $"Срок годности: {ShelfLifeDays} (годен до: {expirationDate:dd.MM.yyyy})";
    }
}

public class Program
{
    public static void Main()
    {
        Console.WriteLine("ВВОД ДАННЫХ О ТОВАРЕ:");
        Console.Write("Введите наименование товара: ");
        string name = Console.ReadLine();

        Console.Write("Введите производителя товара: ");
        string manufacturer = Console.ReadLine();

        Console.Write("Введите цену: ");
        decimal price;
        while (!decimal.TryParse(Console.ReadLine(), out price) || price < 0)
        {
            Console.Write("Некорректная цена. Введите положительное число: ");
        }

        Console.Write("Введите дату производства (формат дд.мм.гггг): ");
        DateTime productionDate;
        while (!DateTime.TryParseExact(Console.ReadLine(), "dd.MM.yyyy", null, System.Globalization.DateTimeStyles.None, out productionDate))
        {
            Console.Write("Некорректная дата. Используйте формат дд.мм.гггг. Введите дату снова: ");
        }

        Console.Write("Введите срок годности в днях: ");
        int shelfLife;
        while (!int.TryParse(Console.ReadLine(), out shelfLife) || shelfLife < 0)
        {
            Console.Write("Некорректный срок. Введите положительное целое число: ");
        }

        Product product = new Product(name, manufacturer, price, productionDate, shelfLife);
        Console.Clear();

        Console.WriteLine("\nИнформация о товаре:");
        Console.WriteLine(product);

    }
}
