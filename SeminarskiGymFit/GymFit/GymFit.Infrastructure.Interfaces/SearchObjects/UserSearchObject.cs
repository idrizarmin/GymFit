using GymFit.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
