using GymFit.Core.Enums;

namespace GymFit.Core
{
    public class PostDto :BaseDto
    {
        public string title { get; set; } = null!;
        public string content { get; set; } = null!;
        public DateTime PublishDate { get; set; }
        public PostStatus Status { get; set; }


       
    }
}
