using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LibraryConsoleApp.Models
{
    public class Reader
    {
        public int ReaderId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string LibraryCardNumber { get; set; }
        public string Phone { get; set; }
        public DateTime RegistrationDate { get; set; }
        public bool IsActive { get; set; }

        public override string ToString()
        {
            return $"[{ReaderId}] {FirstName} {LastName} (Card: {LibraryCardNumber}) - " +
                   $"Active: {(IsActive ? "Yes" : "No")}";
        }
    }
}
