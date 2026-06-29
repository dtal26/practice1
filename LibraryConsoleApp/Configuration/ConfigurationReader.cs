using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;


namespace LibraryConsoleApp.Configuration
{
    /// <summary>
    /// Класс для чтения настроек из файла appsettings.json
    /// </summary>
    public static class ConfigurationReader
    {
        private static IConfiguration _configuration;

        public static string GetConnectionString()
        {
            if (_configuration == null)
            {
                var builder = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory()) 
                    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                    .Build();
                _configuration = builder;
            }

            var connectionString = _configuration.GetConnectionString("LibraryDB");

            if (string.IsNullOrEmpty(connectionString))
            {
                throw new Exception("Строка подключения 'LibraryDB' не найдена в appsettings.json");
            }
            return connectionString;
        }
    }
}
