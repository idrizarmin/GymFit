﻿namespace GymFit.Core
{
    public class GymUpsertDto : BaseUpsertDto
    {
        public string Name { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string? Website { get; set; }


    }
}
