using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class ReservationBarChartSearchObject
    {
        public int? year { get; set; }= DateTime.Now.Year;

    }
}
