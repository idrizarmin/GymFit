﻿// <auto-generated />
using System;
using GymFit.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace GymFit.Infrastructure.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20231126150833_addedPostEntity")]
    partial class addedPostEntity
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.4")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("GymFit.Core.Arrivals", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("ArrivalTime")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DepartureTime")
                        .HasColumnType("datetime2");

                    b.Property<int>("GymId")
                        .HasColumnType("int");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("ReservationId")
                        .HasColumnType("int");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<int>("UserPackageId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("GymId");

                    b.HasIndex("ReservationId");

                    b.HasIndex("UserId");

                    b.HasIndex("UserPackageId");

                    b.ToTable("Arrivals");
                });

            modelBuilder.Entity("GymFit.Core.Certificates", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<string>("Issuer")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Certificates");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsDeleted = false,
                            Issuer = "Arena Mostar",
                            Title = "Personalni trener"
                        },
                        new
                        {
                            Id = 2,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsDeleted = false,
                            Issuer = "DIF Mostar",
                            Title = "Sportski trener"
                        });
                });

            modelBuilder.Entity("GymFit.Core.City", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("CountryId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsActive")
                        .HasColumnType("bit");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ZipCode")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("CountryId");

                    b.ToTable("Citys");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CountryId = 1,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Mostar",
                            ZipCode = "88000"
                        },
                        new
                        {
                            Id = 2,
                            CountryId = 1,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Sarajevo",
                            ZipCode = "77000"
                        },
                        new
                        {
                            Id = 3,
                            CountryId = 1,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Zenica",
                            ZipCode = "72000"
                        });
                });

            modelBuilder.Entity("GymFit.Core.ClientProgress", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal?>("Arms")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("BMI")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Calf")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Chest")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<decimal?>("Height")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Hips")
                        .HasColumnType("decimal(18,2)");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<decimal?>("Quadriceps")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Shoulders")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Stomach")
                        .HasColumnType("decimal(18,2)");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<decimal?>("Waist")
                        .HasColumnType("decimal(18,2)");

                    b.Property<decimal?>("Weight")
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("ClientProgress");
                });

            modelBuilder.Entity("GymFit.Core.Country", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Abbreviation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsActive")
                        .HasColumnType("bit");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Countries");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Abbreviation = "BIH",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Bosnia and Herzegovina"
                        },
                        new
                        {
                            Id = 2,
                            Abbreviation = "HR",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Croatia"
                        },
                        new
                        {
                            Id = 3,
                            Abbreviation = "SRB",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Serbia"
                        },
                        new
                        {
                            Id = 4,
                            Abbreviation = "CG",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Montenegro"
                        },
                        new
                        {
                            Id = 5,
                            Abbreviation = "SLO",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Slovenia"
                        },
                        new
                        {
                            Id = 6,
                            Abbreviation = "AT",
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            IsActive = true,
                            IsDeleted = false,
                            Name = "Austria"
                        });
                });

            modelBuilder.Entity("GymFit.Core.GroupReservations", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<bool>("Arrived")
                        .HasColumnType("bit");

                    b.Property<DateTime>("ConfirmationDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("ReservationId")
                        .HasColumnType("int");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ReservationId");

                    b.HasIndex("UserId");

                    b.ToTable("GroupReservations");
                });

            modelBuilder.Entity("GymFit.Core.Gym", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Address")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("CityId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("PhotoId")
                        .HasColumnType("int");

                    b.Property<string>("Website")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("CityId");

                    b.HasIndex("PhotoId");

                    b.ToTable("Gyms");
                });

            modelBuilder.Entity("GymFit.Core.Notification", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Content")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DateRead")
                        .HasColumnType("datetime2");

                    b.Property<bool?>("Deleted")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool?>("Read")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("Seen")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("SendOnDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Notifications");
                });

            modelBuilder.Entity("GymFit.Core.Photo", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("ContentType")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<byte[]>("Data")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("Photos");
                });

            modelBuilder.Entity("GymFit.Core.Post", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("PhotoId")
                        .IsRequired()
                        .HasColumnType("int");

                    b.Property<DateTime>("PublishDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("Status")
                        .HasColumnType("int");

                    b.Property<string>("content")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("PhotoId");

                    b.ToTable("Post");
                });

            modelBuilder.Entity("GymFit.Core.Reservation", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("DaysOfWeek")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("Duration")
                        .HasColumnType("int");

                    b.Property<DateTime>("EndDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("GymId")
                        .HasColumnType("int");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<int?>("MaxCapacity")
                        .HasColumnType("int");

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("PauseDuration")
                        .HasColumnType("int");

                    b.Property<DateTime>("ReservationDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("StartDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("Status")
                        .HasColumnType("int");

                    b.Property<int?>("TrainerId")
                        .IsRequired()
                        .HasColumnType("int");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<bool?>("isUsed")
                        .HasColumnType("bit");

                    b.HasKey("Id");

                    b.HasIndex("GymId");

                    b.HasIndex("TrainerId");

                    b.HasIndex("UserId");

                    b.ToTable("Reservations");
                });

            modelBuilder.Entity("GymFit.Core.TrainerCertificate", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("CertificateId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("DateOfAchievement")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<string>("Issuer")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("TrainerId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("CertificateId");

                    b.HasIndex("TrainerId");

                    b.ToTable("TrainerCertificates");
                });

            modelBuilder.Entity("GymFit.Core.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("CityId")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("DateOfBirth")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FirstName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("Gender")
                        .HasColumnType("int");

                    b.Property<bool>("IsActive")
                        .HasColumnType("bit");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<bool>("IsVerified")
                        .HasColumnType("bit");

                    b.Property<string>("LastName")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PasswordSalt")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("PhotoId")
                        .HasColumnType("int");

                    b.Property<string>("ProfessionalTitle")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("Role")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("CityId");

                    b.HasIndex("PhotoId");

                    b.ToTable("Users");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            DateOfBirth = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            Email = "gymFit_admin@gmail.com",
                            FirstName = "GymFIT",
                            Gender = 0,
                            IsActive = true,
                            IsDeleted = false,
                            IsVerified = true,
                            LastName = "Armin",
                            PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=",
                            PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                            PhoneNumber = "38763321321",
                            ProfessionalTitle = "Admin",
                            Role = 0
                        },
                        new
                        {
                            Id = 2,
                            CreatedAt = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            DateOfBirth = new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                            Email = "gymFit_trener@gmail.com",
                            FirstName = "GymFIT_Trener",
                            Gender = 0,
                            IsActive = true,
                            IsDeleted = false,
                            IsVerified = true,
                            LastName = "Idriz",
                            PasswordHash = "b4I5yA4Mp+0Pg1C3EsKU17sS13eDExGtBjjI07Vh/JM=",
                            PasswordSalt = "1wQEjdSFeZttx6dlvEDjOg==",
                            PhoneNumber = "38763321321",
                            ProfessionalTitle = "Trener",
                            Role = 2
                        });
                });

            modelBuilder.Entity("GymFit.Core.UserPackage", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("ActivateOnDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("ActivationDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("ExpirationDate")
                        .HasColumnType("datetime2");

                    b.Property<bool>("Expired")
                        .HasColumnType("bit");

                    b.Property<bool>("IsDeleted")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValue(false);

                    b.Property<bool>("IsPaused")
                        .HasColumnType("bit");

                    b.Property<DateTime?>("ModifiedAt")
                        .HasColumnType("datetime2");

                    b.Property<int?>("PauseDuration")
                        .HasColumnType("int");

                    b.Property<DateTime?>("PausedOnDate")
                        .HasColumnType("datetime2");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("UserPackages");
                });

            modelBuilder.Entity("GymFit.Core.Arrivals", b =>
                {
                    b.HasOne("GymFit.Core.Gym", "Gym")
                        .WithMany("Arrivals")
                        .HasForeignKey("GymId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("GymFit.Core.Reservation", "Reservation")
                        .WithMany("Arrivals")
                        .HasForeignKey("ReservationId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("Arrivals")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.HasOne("GymFit.Core.UserPackage", "UserPackage")
                        .WithMany("Arrivals")
                        .HasForeignKey("UserPackageId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("Gym");

                    b.Navigation("Reservation");

                    b.Navigation("User");

                    b.Navigation("UserPackage");
                });

            modelBuilder.Entity("GymFit.Core.City", b =>
                {
                    b.HasOne("GymFit.Core.Country", "Country")
                        .WithMany("Cities")
                        .HasForeignKey("CountryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Country");
                });

            modelBuilder.Entity("GymFit.Core.ClientProgress", b =>
                {
                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("ClientProgress")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("GymFit.Core.GroupReservations", b =>
                {
                    b.HasOne("GymFit.Core.Reservation", "Reservation")
                        .WithMany("GroupReservations")
                        .HasForeignKey("ReservationId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("GroupReservations")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("Reservation");

                    b.Navigation("User");
                });

            modelBuilder.Entity("GymFit.Core.Gym", b =>
                {
                    b.HasOne("GymFit.Core.City", "City")
                        .WithMany("Gyms")
                        .HasForeignKey("CityId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("GymFit.Core.Photo", "Photo")
                        .WithMany("Gyms")
                        .HasForeignKey("PhotoId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("City");

                    b.Navigation("Photo");
                });

            modelBuilder.Entity("GymFit.Core.Notification", b =>
                {
                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("Notifications")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("GymFit.Core.Post", b =>
                {
                    b.HasOne("GymFit.Core.Photo", "Photo")
                        .WithMany("Posts")
                        .HasForeignKey("PhotoId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Photo");
                });

            modelBuilder.Entity("GymFit.Core.Reservation", b =>
                {
                    b.HasOne("GymFit.Core.Gym", "Gym")
                        .WithMany("Reservations")
                        .HasForeignKey("GymId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("GymFit.Core.User", "Trainer")
                        .WithMany("TrainerReservations")
                        .HasForeignKey("TrainerId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("UserReservations")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("Gym");

                    b.Navigation("Trainer");

                    b.Navigation("User");
                });

            modelBuilder.Entity("GymFit.Core.TrainerCertificate", b =>
                {
                    b.HasOne("GymFit.Core.Certificates", "Certificate")
                        .WithMany("TrainerCertificates")
                        .HasForeignKey("CertificateId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("GymFit.Core.User", "Trainer")
                        .WithMany("TrainerCertificates")
                        .HasForeignKey("TrainerId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Certificate");

                    b.Navigation("Trainer");
                });

            modelBuilder.Entity("GymFit.Core.User", b =>
                {
                    b.HasOne("GymFit.Core.City", null)
                        .WithMany("Users")
                        .HasForeignKey("CityId");

                    b.HasOne("GymFit.Core.Photo", "Photo")
                        .WithMany("Users")
                        .HasForeignKey("PhotoId");

                    b.Navigation("Photo");
                });

            modelBuilder.Entity("GymFit.Core.UserPackage", b =>
                {
                    b.HasOne("GymFit.Core.User", "User")
                        .WithMany("UserPackages")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("GymFit.Core.Certificates", b =>
                {
                    b.Navigation("TrainerCertificates");
                });

            modelBuilder.Entity("GymFit.Core.City", b =>
                {
                    b.Navigation("Gyms");

                    b.Navigation("Users");
                });

            modelBuilder.Entity("GymFit.Core.Country", b =>
                {
                    b.Navigation("Cities");
                });

            modelBuilder.Entity("GymFit.Core.Gym", b =>
                {
                    b.Navigation("Arrivals");

                    b.Navigation("Reservations");
                });

            modelBuilder.Entity("GymFit.Core.Photo", b =>
                {
                    b.Navigation("Gyms");

                    b.Navigation("Posts");

                    b.Navigation("Users");
                });

            modelBuilder.Entity("GymFit.Core.Reservation", b =>
                {
                    b.Navigation("Arrivals");

                    b.Navigation("GroupReservations");
                });

            modelBuilder.Entity("GymFit.Core.User", b =>
                {
                    b.Navigation("Arrivals");

                    b.Navigation("ClientProgress");

                    b.Navigation("GroupReservations");

                    b.Navigation("Notifications");

                    b.Navigation("TrainerCertificates");

                    b.Navigation("TrainerReservations");

                    b.Navigation("UserPackages");

                    b.Navigation("UserReservations");
                });

            modelBuilder.Entity("GymFit.Core.UserPackage", b =>
                {
                    b.Navigation("Arrivals");
                });
#pragma warning restore 612, 618
        }
    }
}
