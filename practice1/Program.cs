using System;
using System.Text;
using System.Globalization;


class Program
{
    static void Main()
    {
        string result = CalculateCompoundInterest(1000, 3, 10);
        Console.WriteLine(result);
    }

    public static string CalculateCompoundInterest(double initialDeposit, int years, double interestRate)
    {
        if (initialDeposit <= 0 || years <= 0 || interestRate <= 0)
        {
            throw new ArgumentException("Все параметры должны быть положительными");
        }

        StringBuilder sb = new StringBuilder();
        double currentAmount = initialDeposit;
        double multiplier = 1 + (interestRate / 100);

        for (int year = 1; year <= years; year++)
        {
            currentAmount *= multiplier;

            string formattedAmount = currentAmount.ToString("F2", CultureInfo.InvariantCulture);
            sb.AppendLine($"Год {year}: {formattedAmount} руб.");
        }
        return sb.ToString().TrimEnd('\r', '\n');
    }
}