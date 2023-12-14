using System.Security.Principal;

namespace GymFit.Infrastructure.Interfaces
{
    public class UserPackageSearchObject : BaseSearchObject
    {
        public bool expired { get; set; }
    }
}
