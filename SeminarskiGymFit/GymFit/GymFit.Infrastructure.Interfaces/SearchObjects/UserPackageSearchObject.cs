﻿using System.Security.Principal;

namespace GymFit.Infrastructure.Interfaces
{
    public class UserPackageSearchObject : BaseSearchObject
    {
        public bool? expired { get; set; }

        public int packageId { get; set; }

        public int userId { get; set; }

        public DateTime? fromDate { get; set; }

        public DateTime? toDate { get; set; }

    }
}
