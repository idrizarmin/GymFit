
namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class NotificationsSearchObject :BaseSearchObject
    {
        public string? content { get; set; }
        public long? userId { get; set; }
        public bool? seen { get; set; }



    }
}
