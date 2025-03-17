namespace DmWebPlatform.Domain.DTOs
{
    public class EventDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public string Place { get; set; }
        public DateOnly Date { get; set; }
        public TimeOnly Time { get; set; }
        public string Description { get; set; }
        public string AdditionalInfo { get; set; }
        public string Images { get; set; }
    }
}