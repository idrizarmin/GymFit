using GymFit.Core;
using GymFit.Core.Enums;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder) 
        {
            SeedCountries(modelBuilder);
            SeedCities(modelBuilder);
            SeedUsers(modelBuilder);
            SeedCertificates(modelBuilder);
            SeedGyms(modelBuilder);
            SeedPackages(modelBuilder);
            SeedUserPackages(modelBuilder);
            SeedNotifications(modelBuilder);
            SeedPosts(modelBuilder);
            SeedReservaations(modelBuilder);

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
                    LastName = "Admin",
                    Email = "admin@gmail.com",
                    Role = Role.Administrator,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", 
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
                    FirstName = "Trener1",
                    LastName = "Trener1",
                    Email = "trener@gmail.com",
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
                }, 
                new()
                {
                    Id = 3,
                    FirstName = "Trener2",
                    LastName = "Trener2",
                    Email = "trener@gmail.com",
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
                },
                new()
                {
                    Id = 4,
                    FirstName = "User",
                    LastName = "User",
                    Email = "user@gmail.com",
                    Role = Role.Korisnik,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", //Plain text: test
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    PhoneNumber = "38763321321",
                    IsVerified = true,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Gender = Gender.Female,
                    DateOfBirth = _dateTime,
                    ProfessionalTitle = "User"
                },
                new()
                {
                    Id = 5,
                    FirstName = "User2",
                    LastName = "User2",
                    Email = "user2@gmail.com",
                    Role = Role.Korisnik,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", 
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    PhoneNumber = "38763321321",
                    IsVerified = true,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Gender = Gender.Male,
                    DateOfBirth = _dateTime,
                    ProfessionalTitle = "User"
                },
                new()
                {
                    Id = 6,
                    FirstName = "Admin2",
                    LastName = "Admin2",
                    Email = "admin2@gmail.com",
                    Role = Role.Administrator,
                    PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=",
                    PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                    PhoneNumber = "38763321321",
                    IsVerified = true,
                    IsActive = true,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    Gender = Gender.Female,
                    DateOfBirth = _dateTime,
                    ProfessionalTitle = "Admin"
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
                    Description="Najbolja ponuda sportskih aktivnosti u GymFit",
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
                    Description = "Najbolja ponuda sportskih aktivnosti u GymFit",
                    Website = "www.gymfit.com",
                    Name = "GymFit2",
                    PhoneNumber = "38762211212"
                });
        }
        private void SeedPackages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Package>().HasData(
              new()
              {
                  Id = 1,
                  CreatedAt = _dateTime,
                  ModifiedAt = null,
                  description = "Standardna clanarina",
                  name ="Standard",
                  IsDeleted=false,
                  price =50

              },
              new() {
                  Id = 2,
                  CreatedAt = _dateTime,
                  ModifiedAt = null,
                  description = "Premium članarina, neogranicen broj posjeta",
                  name = "Premium",
                  IsDeleted = false,
                  price = 70
              }
             ); 
        }
        private void SeedUserPackages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserPackage>().HasData(
                new()
                {
                    Id = 1,
                    CreatedAt = DateTime.Now,
                    ModifiedAt = null,
                    ActivationDate = DateTime.Now,
                    ExpirationDate = DateTime.Now.AddMonths(2),
                    IsDeleted = false,
                    Expired= false,
                    IsPaused= false,
                    packageId = 1,
                    UserId = 4,
                    ActivateOnDate= DateTime.Now,
                    PauseDuration=0,
                    PausedOnDate= DateTime.Now,
                    
                },
                new()
                {
                    Id = 2,
                    CreatedAt = DateTime.Now,
                    ModifiedAt = null,
                    ActivationDate = DateTime.Now,
                    ExpirationDate = DateTime.Now.AddMonths(1),
                    IsDeleted = false,
                    Expired = false,
                    IsPaused = false,
                    packageId = 1,
                    UserId = 5,
                    ActivateOnDate = DateTime.Now,
                    PauseDuration = 0,
                    PausedOnDate = DateTime.Now,
                }, new()
                {
                    Id = 3,
                    CreatedAt = DateTime.Now.AddMonths(-2),
                    ModifiedAt = null,
                    ActivationDate = DateTime.Now.AddMonths(-2),
                    ExpirationDate = DateTime.Now.AddMonths(-1),
                    IsDeleted = false,
                    Expired = true,
                    IsPaused = false,
                    packageId = 1,
                    UserId = 4,
                    ActivateOnDate = DateTime.Now,
                    PauseDuration = 0,
                    PausedOnDate = DateTime.Now,

                },
                new()
                {
                    Id = 4,
                    CreatedAt = DateTime.Now.AddMonths(-2),
                    ModifiedAt = null,
                    ActivationDate = DateTime.Now.AddMonths(-2),
                    ExpirationDate = DateTime.Now.AddMonths(-1),
                    IsDeleted = false,
                    Expired = true,
                    IsPaused = false,
                    packageId = 1,
                    UserId = 5,
                    ActivateOnDate = DateTime.Now,
                    PauseDuration = 0,
                    PausedOnDate = DateTime.Now,
                }
                );
        }
        private void SeedNotifications(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Notification>().HasData(
                new()
                {
                    Id = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Deleted = false,
                    Content="Sretnu novu godinu želi vam GymFit",
                    Read=false,
                    DateRead= null,
                    SendOnDate= DateTime.Now,
                    Seen=null,
                    UserId=4,

                },
                new()
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Deleted = false,
                    Content = "Imamo novog trenera za yogu, pogledajte naše trenere",
                    Read = false,
                    DateRead = null,
                    SendOnDate = DateTime.Now,
                    Seen = null,
                    UserId = 4,
                },
                 new()
                 {
                     Id = 3,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Deleted = false,
                     Content = "Sretnu novu godinu želi vam GymFit",
                     Read = false,
                     DateRead = null,
                     SendOnDate = DateTime.Now,
                     Seen = null,
                     UserId = 5,

                 },
                new()
                {
                    Id = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Deleted = false,
                    Content = "Imamo novog trenera za yogu, pogledajte naše trenere",
                    Read = false,
                    DateRead = null,
                    SendOnDate = DateTime.Now,
                    Seen = null,
                    UserId = 5,
                }
                );
        }
        private void SeedPosts (ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>().HasData(
                new()
                {
                    Id = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    title= "Sretna nova godina",
                    content = "Sretnu novu godinu želi vam GymFit",
                    PublishDate= DateTime.Now,

                },
                new()
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    title= "Novi trener",
                    content = "Imamo novog trenera za yogu, pogledajte naše trenere",
                    PublishDate = DateTime.Now,
                },
                new()
                {
                    Id = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    title = "Novi trener",
                    content = "Imamo novog trenera - Armin Idriz",
                    PublishDate = DateTime.Now,
                },
                 new()
                 {
                     Id = 4,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     title = "Neradni dani",
                     content = "TEretana GymFit neće raditi 2 dana nakon nove godine",
                     PublishDate = DateTime.Now,
                 });
        }
        private void SeedReservaations(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Reservation>().HasData(
                new()
                {
                    Id = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Snaga",
                    ReservationDate = new DateTime(2024, 3, 10, 15, 00, 0),
                    StartDate = new DateTime(2024, 3, 10, 15, 00, 0),
                    EndDate = new DateTime(2024, 3, 10, 16, 00, 0),
                    Status = ReservationStatus.Finished,
                    isUsed = true,
                    GymId = 2,
                    UserId = 4,
                    TrainerId = 3,
                    

                },
                new()
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "HIT",
                    ReservationDate = new DateTime(2024, 3, 11, 15, 00, 0),
                    StartDate = new DateTime(2024, 3, 11, 16, 00, 0),
                    EndDate = new DateTime(2024, 3, 11, 17, 00, 0),
                    Status = ReservationStatus.Finished,
                    isUsed = true,
                    GymId = 2,
                    UserId = 4,
                    TrainerId = 3,
                },
                new()
                {
                    Id = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "CrossFit",
                    ReservationDate = new DateTime(2024, 3, 14, 15, 00, 0),
                    StartDate = new DateTime(2024, 3, 14, 15, 00, 0),
                    EndDate = new DateTime(2024, 3, 14, 16, 00, 0),
                    Status = ReservationStatus.Cancelled,
                    isUsed = false,
                    GymId = 2,
                    UserId = 4,
                    TrainerId = 3,
                },
                 new()
                 {
                     Id = 4,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Description= "Individualni",
                     ReservationDate = new DateTime(2024, 3, 13, 19, 00, 0),
                     StartDate = new DateTime(2024, 3, 13, 19, 00, 0),
                     EndDate = new DateTime(2024, 3, 13, 20, 00, 0),
                     Status = ReservationStatus.Finished,
                     isUsed = true,
                     GymId = 2,
                     UserId = 4,
                     TrainerId = 2,
                 },
                  new()
                  {
                      Id = 5,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      IsDeleted = false,
                      Description= "Snaga",
                      ReservationDate = new DateTime(2024, 3, 18, 18, 00, 0),
                      StartDate = new DateTime(2024, 3, 18, 18, 00, 0),
                      EndDate = new DateTime(2024, 3, 18, 19, 00, 0),
                      Status = ReservationStatus.Confirmed,
                      isUsed = false,
                      GymId = 2,
                      UserId = 4,
                      TrainerId = 2,


                  },
                new()
                {
                    Id = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Kardio",
                    ReservationDate = new DateTime(2024, 3, 19, 15, 00, 0),
                    StartDate = new DateTime(2024, 3, 19, 15, 00, 0),
                    EndDate = new DateTime(2024, 3, 19, 16, 00, 0),
                    Status = ReservationStatus.Confirmed,
                    isUsed = false,
                    GymId = 2,
                    UserId = 4,
                    TrainerId = 2,
                },
                new()
                {
                    Id = 7,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Kombinovani",
                    ReservationDate = new DateTime(2024, 3, 20, 8, 00, 0),
                    StartDate = new DateTime(2024, 3, 20, 8, 00, 0),
                    EndDate = new DateTime(2024, 3, 20, 9, 00, 0),
                    Status = ReservationStatus.Created,
                    isUsed = false,
                    GymId = 2,
                    UserId = 4,
                    TrainerId = 2,
                },
                 new()
                 {
                     Id = 8,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                    Description= "CrossFit",
                     ReservationDate = new DateTime(2024, 3, 21, 10, 00, 0),
                     StartDate = new DateTime(2024, 3, 21, 10, 00, 0),
                     EndDate = new DateTime(2024, 3, 21, 11, 00, 0),
                     Status = ReservationStatus.Created,
                     isUsed = false,
                     GymId = 2,
                     UserId = 4,
                     TrainerId = 2,
                 },
                  new()
                  {
                      Id = 9,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      IsDeleted = false,
                      Description= "Yoga",
                      ReservationDate = new DateTime(2024, 3, 11, 11, 00, 0),
                      StartDate = new DateTime(2024, 3, 11, 11, 00, 0),
                      EndDate = new DateTime(2024, 3, 11, 12, 00, 0),
                      Status = ReservationStatus.Finished,
                      isUsed = true,
                      GymId = 2,
                      UserId = 5,
                      TrainerId = 2,


                  },
                new()
                {
                    Id = 10,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Pilates",
                    ReservationDate = new DateTime(2024, 3, 12, 14, 00, 0),
                    StartDate = new DateTime(2024, 3, 12, 14, 00, 0),
                    EndDate = new DateTime(2024, 3, 12, 15, 00, 0),
                    Status = ReservationStatus.Finished,
                    isUsed = true,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                },
                new()
                {
                    Id = 11,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Pilates",
                    ReservationDate = new DateTime(2024, 3, 18, 14, 00, 0),
                    StartDate = new DateTime(2024, 3, 18, 14, 00, 0),
                    EndDate = new DateTime(2024, 3, 18, 15, 00, 0),
                    Status = ReservationStatus.Cancelled,
                    isUsed = false,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                },
                 new()
                 {
                     Id = 12,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Description= "Pilates",
                     ReservationDate = new DateTime(2024, 3, 13, 15, 00, 0),
                     StartDate = new DateTime(2024, 3, 13, 15, 00, 0),
                     EndDate = new DateTime(2024, 3, 13, 16, 00, 0),
                     Status = ReservationStatus.Finished,
                     isUsed = true,
                     GymId = 2,
                     UserId = 5,
                     TrainerId = 3,
                 },
                  new()
                  {
                      Id = 13,
                      CreatedAt = _dateTime,
                      ModifiedAt = null,
                      IsDeleted = false,
                      Description= "Kombinovani",
                      ReservationDate = new DateTime(2024, 3, 20, 15, 00, 0),
                      StartDate = new DateTime(2024, 3, 20, 15, 00, 0),
                      EndDate = new DateTime(2024, 3, 20, 16, 00, 0),
                      Status = ReservationStatus.Confirmed,
                      isUsed = false,
                      GymId = 2,
                      UserId = 5,
                      TrainerId = 3,
                  },
                new()
                {
                    Id = 14,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Kardio",
                    ReservationDate = new DateTime(2024, 3, 22, 15, 00, 0),
                    StartDate = new DateTime(2024, 3, 22, 15, 00, 0),
                    EndDate = new DateTime(2024, 3, 22, 16, 00, 0),
                    Status = ReservationStatus.Confirmed,
                    isUsed = false,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                },
                new()
                {
                    Id = 15,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description= "Yoga",
                    ReservationDate = new DateTime(2024, 3, 23, 17, 00, 0),
                    StartDate = new DateTime(2024, 3, 23, 17, 00, 0),
                    EndDate = new DateTime(2024, 3, 23, 18, 00, 0),
                    Status = ReservationStatus.Created,
                    isUsed = false,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                },
                 new()
                 {
                     Id = 16,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Description= "Pilates",
                     ReservationDate = new DateTime(2024, 3, 23, 20, 00, 0),
                     StartDate = new DateTime(2024, 3, 23, 20, 00, 0),
                     EndDate = new DateTime(2024, 3, 23, 21, 00, 0),
                     Status = ReservationStatus.Created,
                     isUsed = false,
                     GymId = 2,
                     UserId = 5,
                     TrainerId = 3,
                 },
                 new()
                 {
                     Id = 17,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Description = "Pilates",
                     ReservationDate = new DateTime(2024, 3, 24, 22, 00, 0),
                     StartDate = new DateTime(2024, 3, 24, 22, 00, 0),
                     EndDate = new DateTime(2024, 3, 24, 23, 00, 0),
                     Status = ReservationStatus.Created,
                     isUsed = false,
                     GymId = 2,
                     UserId = 5,
                     TrainerId = 3,
                 },
                 new()
                 {
                     Id = 18,
                     CreatedAt = _dateTime,
                     ModifiedAt = null,
                     IsDeleted = false,
                     Description = "Pilates",
                     ReservationDate = new DateTime(2024, 3, 26, 22, 00, 0),
                     StartDate = new DateTime(2024, 3, 26, 22, 00, 0),
                     EndDate = new DateTime(2024, 3, 26, 23, 00, 0),
                     Status = ReservationStatus.Created,
                     isUsed = false,
                     GymId = 2,
                     UserId = 5,
                     TrainerId = 2,
                 },
                new()
                {
                    Id = 19,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description = "Pilates",
                    ReservationDate = new DateTime(2024, 3, 19, 22, 00, 0),
                    StartDate = new DateTime(2024, 3, 19, 22, 00, 0),
                    EndDate = new DateTime(2024, 3, 19, 23, 00, 0),
                    Status = ReservationStatus.Cancelled,
                    isUsed = false,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                },
                new()
                {
                    Id = 20,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                    IsDeleted = false,
                    Description = "Pilates",
                    ReservationDate = new DateTime(2024, 3, 13, 8, 00, 0),
                    StartDate = new DateTime(2024, 3, 13, 9, 00, 0),
                    EndDate = new DateTime(2024, 3, 13, 9, 00, 0),
                    Status = ReservationStatus.Finished,
                    isUsed = true,
                    GymId = 2,
                    UserId = 5,
                    TrainerId = 2,
                }

                 );
        }
    }
}
