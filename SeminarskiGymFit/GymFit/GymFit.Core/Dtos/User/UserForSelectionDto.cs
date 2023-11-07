using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Core.Dtos.User
{
    public class UserForSelectionDto :BaseDto
    {
        public string? firstName { get; set; } = null!;
        public string? lastName { get; set; } = null!;
    }
}
