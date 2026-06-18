
class Program
{
    static void Main()
    {
        PrintDiamond(5);
    }

    
    public static void PrintDiamond(int n)
    {
        if (n <= 0 || n / 2 == 0)
        {
            throw new ArgumentException("Число n должно быть положительным нечетным числом");
        }

        int center = n / 2;

        for (int i = 0; i < n; i++)
        {
            int distance = Math.Abs(i - center);
            char[] row = new char[n];

            for (int j = 0; j < n; j++)
            {
                row[j] = ' ';
            }

            row[distance] = 'X';
            row[n - 1 - distance] = 'X';
            Console.WriteLine(new string(row));
        }
    }
}