using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Certificates",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Issuer = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Certificates", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Countries",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Abbreviation = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Countries", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Package",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    price = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Package", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Photos",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GuidId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Data = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    ContentType = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ThumbnailContent = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Photos", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Post",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PublishDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Post", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Citys",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ZipCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    CountryId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Citys", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Citys_Countries_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Countries",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Gyms",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Website = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CityId = table.Column<int>(type: "int", nullable: true),
                    PhotoId = table.Column<int>(type: "int", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gyms", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Gyms_Citys_CityId",
                        column: x => x.CityId,
                        principalTable: "Citys",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Gyms_Photos_PhotoId",
                        column: x => x.PhotoId,
                        principalTable: "Photos",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ProfessionalTitle = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsVerified = table.Column<bool>(type: "bit", nullable: false),
                    IsActive = table.Column<bool>(type: "bit", nullable: false),
                    Gender = table.Column<int>(type: "int", nullable: false),
                    DateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Role = table.Column<int>(type: "int", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PhotoId = table.Column<int>(type: "int", nullable: true),
                    CityId = table.Column<int>(type: "int", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Users_Citys_CityId",
                        column: x => x.CityId,
                        principalTable: "Citys",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Users_Photos_PhotoId",
                        column: x => x.PhotoId,
                        principalTable: "Photos",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ClientProgress",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Height = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Weight = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Shoulders = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Arms = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Chest = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Stomach = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Waist = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Hips = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Quadriceps = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Calf = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    BMI = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ClientProgress", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ClientProgress_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Notifications",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Read = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    Deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    DateRead = table.Column<DateTime>(type: "datetime2", nullable: true),
                    SendOnDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Seen = table.Column<DateTime>(type: "datetime2", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Notifications", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Notifications_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NotificationsRabbit",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Content = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsRead = table.Column<bool>(type: "bit", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NotificationsRabbit", x => x.Id);
                    table.ForeignKey(
                        name: "FK_NotificationsRabbit_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Reservations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ReservationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Duration = table.Column<int>(type: "int", nullable: true),
                    PauseDuration = table.Column<int>(type: "int", nullable: true),
                    MaxCapacity = table.Column<int>(type: "int", nullable: true),
                    Status = table.Column<int>(type: "int", nullable: false),
                    DaysOfWeek = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    isUsed = table.Column<bool>(type: "bit", nullable: true),
                    GymId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    TrainerId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reservations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reservations_Gyms_GymId",
                        column: x => x.GymId,
                        principalTable: "Gyms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Reservations_Users_TrainerId",
                        column: x => x.TrainerId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Reservations_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TrainerCertificates",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DateOfAchievement = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Issuer = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TrainerId = table.Column<int>(type: "int", nullable: false),
                    CertificateId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TrainerCertificates", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TrainerCertificates_Certificates_CertificateId",
                        column: x => x.CertificateId,
                        principalTable: "Certificates",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TrainerCertificates_Users_TrainerId",
                        column: x => x.TrainerId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserPackages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PauseDuration = table.Column<int>(type: "int", nullable: true),
                    IsPaused = table.Column<bool>(type: "bit", nullable: false),
                    Expired = table.Column<bool>(type: "bit", nullable: false),
                    ActivationDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ExpirationDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PausedOnDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ActivateOnDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    packageId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserPackages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserPackages_Package_packageId",
                        column: x => x.packageId,
                        principalTable: "Package",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserPackages_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "GroupReservations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ConfirmationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Arrived = table.Column<bool>(type: "bit", nullable: false),
                    ReservationId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GroupReservations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_GroupReservations_Reservations_ReservationId",
                        column: x => x.ReservationId,
                        principalTable: "Reservations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GroupReservations_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Arrivals",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ArrivalTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DepartureTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ReservationId = table.Column<int>(type: "int", nullable: false),
                    GymId = table.Column<int>(type: "int", nullable: false),
                    UserPackageId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Arrivals", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Arrivals_Gyms_GymId",
                        column: x => x.GymId,
                        principalTable: "Gyms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Arrivals_Reservations_ReservationId",
                        column: x => x.ReservationId,
                        principalTable: "Reservations",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Arrivals_UserPackages_UserPackageId",
                        column: x => x.UserPackageId,
                        principalTable: "UserPackages",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Arrivals_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Traansactions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PayPalTransactionId = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Amount = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    TransactionDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    userPackageId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Traansactions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Traansactions_UserPackages_userPackageId",
                        column: x => x.userPackageId,
                        principalTable: "UserPackages",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.InsertData(
                table: "Certificates",
                columns: new[] { "Id", "CreatedAt", "Issuer", "ModifiedAt", "Title" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "Arena Mostar", null, "Personalni trener" },
                    { 2, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "DIF Mostar", null, "Sportski trener" }
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "Abbreviation", "CreatedAt", "IsActive", "ModifiedAt", "Name" },
                values: new object[,]
                {
                    { 1, "BIH", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Bosnia and Herzegovina" },
                    { 2, "HR", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Croatia" },
                    { 3, "SRB", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Serbia" },
                    { 4, "CG", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Montenegro" },
                    { 5, "SLO", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Slovenia" },
                    { 6, "AT", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Austria" }
                });

            migrationBuilder.InsertData(
                table: "Gyms",
                columns: new[] { "Id", "Address", "CityId", "CreatedAt", "Description", "ModifiedAt", "Name", "PhoneNumber", "PhotoId", "Website" },
                values: new object[,]
                {
                    { 1, "88000 Mostar", null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "Najbolja ponuda sportskih aktivnosti u GymFit", null, "GymFit1", "38762211211", null, "www.gymfit.com" },
                    { 2, "88000 Mostar", null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "Najbolja ponuda sportskih aktivnosti u GymFit", null, "GymFit2", "38762211212", null, "www.gymfit.com" }
                });

            migrationBuilder.InsertData(
                table: "Package",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "description", "name", "price" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Standardna clanarina", "Standard", 50m },
                    { 2, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Premium članarina, neogranicen broj posjeta", "Premium", 70m }
                });

            migrationBuilder.InsertData(
                table: "Post",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "PublishDate", "Status", "content", "title" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9339), 0, "Sretnu novu godinu želi vam GymFit", "Sretna nova godina" },
                    { 2, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9341), 0, "Imamo novog trenera za yogu, pogledajte naše trenere", "Novi trener" },
                    { 3, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9344), 0, "Imamo novog trenera - Armin Idriz", "Novi trener" },
                    { 4, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9346), 0, "TEretana GymFit neće raditi 2 dana nakon nove godine", "Neradni dani" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "CityId", "CreatedAt", "DateOfBirth", "Email", "FirstName", "Gender", "IsActive", "IsVerified", "LastName", "ModifiedAt", "PasswordHash", "PasswordSalt", "PhoneNumber", "PhotoId", "ProfessionalTitle", "Role" },
                values: new object[,]
                {
                    { 1, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "admin@gmail.com", "GymFIT", 0, true, true, "Admin", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "Admin", 0 },
                    { 2, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "trener@gmail.com", "Trener1", 0, true, true, "Trener1", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "Trener", 2 },
                    { 3, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "trener@gmail.com", "Trener2", 0, true, true, "Trener2", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "Trener", 2 },
                    { 4, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "user@gmail.com", "User", 1, true, true, "User", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "User", 1 },
                    { 5, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "user2@gmail.com", "User2", 0, true, true, "User2", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "User", 1 },
                    { 6, null, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), "admin2@gmail.com", "Admin2", 1, true, true, "Admin2", null, "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=", "1wQEjdSFeZttx6dlvEDjOg==", "38763321321", null, "Admin", 0 }
                });

            migrationBuilder.InsertData(
                table: "Citys",
                columns: new[] { "Id", "CountryId", "CreatedAt", "IsActive", "ModifiedAt", "Name", "ZipCode" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Mostar", "88000" },
                    { 2, 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Sarajevo", "77000" },
                    { 3, 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), true, null, "Zenica", "72000" }
                });

            migrationBuilder.InsertData(
                table: "Notifications",
                columns: new[] { "Id", "Content", "CreatedAt", "DateRead", "Deleted", "ModifiedAt", "Read", "Seen", "SendOnDate", "UserId" },
                values: new object[,]
                {
                    { 1, "Sretnu novu godinu želi vam GymFit", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, false, null, false, null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9307), 4 },
                    { 2, "Imamo novog trenera za yogu, pogledajte naše trenere", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, false, null, false, null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9312), 4 },
                    { 3, "Sretnu novu godinu želi vam GymFit", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, false, null, false, null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9314), 5 },
                    { 4, "Imamo novog trenera za yogu, pogledajte naše trenere", new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, false, null, false, null, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9317), 5 }
                });

            migrationBuilder.InsertData(
                table: "Reservations",
                columns: new[] { "Id", "CreatedAt", "DaysOfWeek", "Description", "Duration", "EndDate", "GymId", "MaxCapacity", "ModifiedAt", "PauseDuration", "ReservationDate", "StartDate", "Status", "TrainerId", "UserId", "isUsed" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Snaga", null, new DateTime(2024, 3, 10, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 10, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 10, 15, 0, 0, 0, DateTimeKind.Unspecified), 4, 3, 4, true },
                    { 2, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "HIT", null, new DateTime(2024, 3, 11, 17, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 11, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 11, 16, 0, 0, 0, DateTimeKind.Unspecified), 4, 3, 4, true },
                    { 3, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "CrossFit", null, new DateTime(2024, 3, 14, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 14, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 14, 15, 0, 0, 0, DateTimeKind.Unspecified), 3, 3, 4, false },
                    { 4, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Individualni", null, new DateTime(2024, 3, 13, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 13, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 13, 19, 0, 0, 0, DateTimeKind.Unspecified), 4, 2, 4, true },
                    { 5, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Snaga", null, new DateTime(2024, 3, 18, 19, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 18, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 18, 18, 0, 0, 0, DateTimeKind.Unspecified), 2, 2, 4, false },
                    { 6, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Kardio", null, new DateTime(2024, 3, 19, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 19, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 19, 15, 0, 0, 0, DateTimeKind.Unspecified), 2, 2, 4, false },
                    { 7, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Kombinovani", null, new DateTime(2024, 3, 20, 9, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 20, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 20, 8, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 4, false },
                    { 8, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "CrossFit", null, new DateTime(2024, 3, 21, 11, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 21, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 21, 10, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 4, false },
                    { 9, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Yoga", null, new DateTime(2024, 3, 11, 12, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 11, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 11, 11, 0, 0, 0, DateTimeKind.Unspecified), 4, 2, 5, true },
                    { 10, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 12, 15, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 12, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 12, 14, 0, 0, 0, DateTimeKind.Unspecified), 4, 2, 5, true },
                    { 11, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 18, 15, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 18, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 18, 14, 0, 0, 0, DateTimeKind.Unspecified), 3, 2, 5, false },
                    { 12, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 13, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 13, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 13, 15, 0, 0, 0, DateTimeKind.Unspecified), 4, 3, 5, true },
                    { 13, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Kombinovani", null, new DateTime(2024, 3, 20, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 20, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 20, 15, 0, 0, 0, DateTimeKind.Unspecified), 2, 3, 5, false },
                    { 14, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Kardio", null, new DateTime(2024, 3, 22, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), 2, 2, 5, false },
                    { 15, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Yoga", null, new DateTime(2024, 3, 23, 18, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 23, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 23, 17, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 5, false },
                    { 16, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 23, 21, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 23, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 23, 20, 0, 0, 0, DateTimeKind.Unspecified), 1, 3, 5, false },
                    { 17, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 24, 23, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 24, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 24, 22, 0, 0, 0, DateTimeKind.Unspecified), 1, 3, 5, false },
                    { 18, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 26, 23, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 26, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 26, 22, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 5, false },
                    { 19, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 19, 23, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 19, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 19, 22, 0, 0, 0, DateTimeKind.Unspecified), 3, 2, 5, false },
                    { 20, new DateTime(2024, 3, 9, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 3, 13, 9, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 3, 13, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 3, 13, 9, 0, 0, 0, DateTimeKind.Unspecified), 4, 2, 5, true }
                });

            migrationBuilder.InsertData(
                table: "UserPackages",
                columns: new[] { "Id", "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "Expired", "IsPaused", "ModifiedAt", "PauseDuration", "PausedOnDate", "UserId", "packageId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9261), new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9245), new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9199), new DateTime(2024, 5, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9250), false, false, null, 0, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9264), 4, 1 },
                    { 2, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9270), new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9267), new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9266), new DateTime(2024, 4, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9268), false, false, null, 0, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9272), 5, 1 },
                    { 3, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9278), new DateTime(2024, 1, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9275), new DateTime(2024, 1, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9273), new DateTime(2024, 2, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9276), true, false, null, 0, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9279), 4, 1 },
                    { 4, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9285), new DateTime(2024, 1, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9282), new DateTime(2024, 1, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9281), new DateTime(2024, 2, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9283), true, false, null, 0, new DateTime(2024, 3, 8, 1, 56, 41, 796, DateTimeKind.Local).AddTicks(9286), 5, 1 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Arrivals_GymId",
                table: "Arrivals",
                column: "GymId");

            migrationBuilder.CreateIndex(
                name: "IX_Arrivals_ReservationId",
                table: "Arrivals",
                column: "ReservationId");

            migrationBuilder.CreateIndex(
                name: "IX_Arrivals_UserId",
                table: "Arrivals",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Arrivals_UserPackageId",
                table: "Arrivals",
                column: "UserPackageId");

            migrationBuilder.CreateIndex(
                name: "IX_Citys_CountryId",
                table: "Citys",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_ClientProgress_UserId",
                table: "ClientProgress",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_GroupReservations_ReservationId",
                table: "GroupReservations",
                column: "ReservationId");

            migrationBuilder.CreateIndex(
                name: "IX_GroupReservations_UserId",
                table: "GroupReservations",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Gyms_CityId",
                table: "Gyms",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Gyms_PhotoId",
                table: "Gyms",
                column: "PhotoId");

            migrationBuilder.CreateIndex(
                name: "IX_Notifications_UserId",
                table: "Notifications",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_NotificationsRabbit_UserId",
                table: "NotificationsRabbit",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_GymId",
                table: "Reservations",
                column: "GymId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_TrainerId",
                table: "Reservations",
                column: "TrainerId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservations_UserId",
                table: "Reservations",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Traansactions_userPackageId",
                table: "Traansactions",
                column: "userPackageId");

            migrationBuilder.CreateIndex(
                name: "IX_TrainerCertificates_CertificateId",
                table: "TrainerCertificates",
                column: "CertificateId");

            migrationBuilder.CreateIndex(
                name: "IX_TrainerCertificates_TrainerId",
                table: "TrainerCertificates",
                column: "TrainerId");

            migrationBuilder.CreateIndex(
                name: "IX_UserPackages_packageId",
                table: "UserPackages",
                column: "packageId");

            migrationBuilder.CreateIndex(
                name: "IX_UserPackages_UserId",
                table: "UserPackages",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_CityId",
                table: "Users",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_PhotoId",
                table: "Users",
                column: "PhotoId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Arrivals");

            migrationBuilder.DropTable(
                name: "ClientProgress");

            migrationBuilder.DropTable(
                name: "GroupReservations");

            migrationBuilder.DropTable(
                name: "Notifications");

            migrationBuilder.DropTable(
                name: "NotificationsRabbit");

            migrationBuilder.DropTable(
                name: "Post");

            migrationBuilder.DropTable(
                name: "Traansactions");

            migrationBuilder.DropTable(
                name: "TrainerCertificates");

            migrationBuilder.DropTable(
                name: "Reservations");

            migrationBuilder.DropTable(
                name: "UserPackages");

            migrationBuilder.DropTable(
                name: "Certificates");

            migrationBuilder.DropTable(
                name: "Gyms");

            migrationBuilder.DropTable(
                name: "Package");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Citys");

            migrationBuilder.DropTable(
                name: "Photos");

            migrationBuilder.DropTable(
                name: "Countries");
        }
    }
}
