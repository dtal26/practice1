namespace LibraryConsoleApp.Models
{
    public class Book
    {
        public Guid BookId { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public string ISBN { get; set; }
        public int? PublishYear { get; set; }
        public bool IsAvailable { get; set; }
        public DateTime AddedDate { get; set; }

        public override string ToString()
        {
            return $"[{BookId}] \"{Title}\" by {Author} ({PublishYear}) - " +
                $"ISBN: {ISBN}, Available: {(IsAvailable ? "Yes" : "No")}";
        }
    }
}