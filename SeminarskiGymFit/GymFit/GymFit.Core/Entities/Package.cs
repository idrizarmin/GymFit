﻿namespace GymFit.Core
{
    public class Package : BaseEntity
    {
        public string name { get; set; }
        public string description { get; set; }
        public decimal price { get; set; }
    }
}
