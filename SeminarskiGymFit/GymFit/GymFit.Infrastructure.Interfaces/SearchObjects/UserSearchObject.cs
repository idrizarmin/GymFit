using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class UserSearchObject : BaseSearchObject
    {
        public string? name { get; set; }
        public Gender? spol{ get; set; }
        public bool? isActive { get; set; }
        public bool? isVerified { get; set; }
    }
}
