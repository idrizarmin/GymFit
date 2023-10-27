using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace GymFit.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder) 
        {
            SeedCountries(modelBuilder);
            SeedCities(modelBuilder);
            SeedUsers(modelBuilder);
            SeedCertificates(modelBuilder);
            //SeedGyms(modelBuilder);
        }

        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>().HasData(
               new()
               {
                   Id = 1,
                   Name = "Bosnia and Herzegovina",
                   Abbreviation = "BIH",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 2,
                   Name = "Croatia",
                   Abbreviation = "HR",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 3,
                   Name = "Serbia",
                   Abbreviation = "SRB",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 4,
                   Name = "Montenegro",
                   Abbreviation = "CG",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 5,
                   Name = "Slovenia",
                   Abbreviation = "SLO",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 6,
                   Name = "Austria",
                   Abbreviation = "AT",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               });
        }
        private void SeedCities(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<City>().HasData(
                new()
                {
                    Id = 1,
                    Name = "Mostar",
                    ZipCode = "88000",
                    CountryId = 1,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                    
                },
                new()
                {
                    Id = 2,
                    Name = "Sarajevo",
                    ZipCode = "77000",
                    CountryId = 1,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new()
                {
                    Id = 3,
                    Name = "Zenica",
                    ZipCode = "72000",
                    CountryId = 1,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
        }
        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new ()
                {
                    Id = 1,
                    FirstName = "GymFIT",
                    LastName = "Armin",
                    Email = "gymFit_admin@gmail.com",
                    Role = Role.Administrator,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    PhoneNumber = "38763321321",
                    IsVerified = true,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Gender= Gender.Male,
                    DateOfBirth= _dateTime,
                    ProfessionalTitle= "Admin"
                },
                new() 
                {
                    Id = 2,
                    FirstName = "GymFIT_Trener",
                    LastName = "Idriz",
                    Email = "gymFit_trener@gmail.com",
                    Role = Role.Trener,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    PhoneNumber = "38763321321",
                    IsVerified = true,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Gender = Gender.Male,
                    DateOfBirth = _dateTime,
                    ProfessionalTitle = "Trener"
                });
        }
        private void SeedCertificates(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Certificates>().HasData(
                new ()
                {
                    Id= 1,
                    CreatedAt= _dateTime,
                    Issuer="Arena Mostar",
                    Title= "Personalni trener",
                    ModifiedAt= null
                },
                new() 
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    Issuer = "DIF Mostar",
                    Title = "Sportski trener",
                    ModifiedAt = null
                });
        }
        private void SeedGyms(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Gym>().HasData(
                new()
                {
                    Id= 1,
                    CreatedAt= _dateTime,
                    ModifiedAt= null,
                    Address= "88000 Mostar",
                    CityId=1,
                    Description="Najbolja ponuda sportskig aktivnosti u GymFit",
                    Website= "www.gymfit.com",
                    Name= "GymFit1",
                    PhoneNumber= "38762211211"
                },
                new()
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Address = "88000 Mostar",
                    CityId = 1,
                    Description = "Najbolja ponuda sportskig aktivnosti u GymFit",
                    Website = "www.gymfit.com",
                    Name = "GymFit2",
                    PhoneNumber = "38762211212"
                });
        }
    }
}
