using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class edit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 1,
                column: "SendOnDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2160));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 2,
                column: "SendOnDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2163));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 3,
                column: "SendOnDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2166));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 4,
                column: "SendOnDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2168));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2186));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2189));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2191));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2193));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 5,
                column: "PublishDate",
                value: new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2195));

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 3, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 3, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 3, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 2, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 16, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 4, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 7, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 7, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 1, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 1, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 1, 19, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 6, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 7, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 8, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 8, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 7, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 10, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 11, 30, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 30, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 30, 11, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 11, 29, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 29, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 29, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 11,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 12, 6, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 14, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 12,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 12, 5, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 5, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 5, 15, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 13,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 5, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 5, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 5, 20, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 14,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 6, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 15,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 7, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 17, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 16,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 7, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 20, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 17,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 8, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 22, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 18,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 12, 9, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 9, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 9, 22, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 19,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 12, 6, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 6, 22, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 20,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 4, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 9, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 21,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 3, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 3, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 3, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 22,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 2, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 16, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 23,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 11, 29, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 29, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 29, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 24,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 2, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 19, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 25,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 7, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 7, 21, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 26,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 8, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 8, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 27,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 11, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 11, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 11, 8, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 28,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 13, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 13, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 13, 10, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 29,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 4, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 4, 11, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 30,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 11, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 11, 27, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 31,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 26, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 26, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 26, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 32,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 2, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 2, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 33,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 12, 10, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 10, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 10, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 34,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 12, 12, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 12, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 12, 12, 18, 0, 0, 0, DateTimeKind.Unspecified), 1 });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2111), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2099), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2049), new DateTime(2025, 2, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2104), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2114) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2120), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2117), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2116), new DateTime(2025, 1, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2119), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2122) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2128), new DateTime(2024, 10, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2125), new DateTime(2024, 10, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2123), new DateTime(2024, 11, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2126), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2129) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2135), new DateTime(2024, 10, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2132), new DateTime(2024, 10, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2131), new DateTime(2024, 11, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2133), new DateTime(2024, 12, 4, 20, 59, 23, 274, DateTimeKind.Local).AddTicks(2136) });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 1,
                column: "SendOnDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(847));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 2,
                column: "SendOnDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(852));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 3,
                column: "SendOnDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(855));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 4,
                column: "SendOnDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(858));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(877));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(880));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(882));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(884));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 5,
                column: "PublishDate",
                value: new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(886));

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 17, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 17, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 17, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 18, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 18, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 18, 16, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 21, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 21, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 21, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 20, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 19, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 26, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 27, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 7,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 28, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 28, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 28, 8, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 8,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 29, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 29, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 29, 10, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 9,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 19, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 11, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 10,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 20, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 11,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 5, 26, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 14, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 12,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 5, 22, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), 4 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 13,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 30, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 14,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 31, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 15,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 31, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 17, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 16,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 30, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 20, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 17,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 24, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 24, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 24, 22, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 18,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 5, 25, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 25, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 25, 22, 0, 0, 0, DateTimeKind.Unspecified), 1 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 19,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 5, 19, 23, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 22, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 22, 0, 0, 0, DateTimeKind.Unspecified), 3 });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 20,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 19, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 9, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 21,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 17, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 17, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 17, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 22,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 18, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 18, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 18, 16, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 23,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 21, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 21, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 21, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 24,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 20, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 19, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 25,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 26, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 18, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 26,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 27, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 27,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 28, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 28, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 28, 8, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 28,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 29, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 29, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 29, 10, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 29,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 19, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 19, 11, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 30,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 20, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 20, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 31,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 26, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 14, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 26, 14, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 32,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 22, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 22, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 33,
                columns: new[] { "EndDate", "ReservationDate", "StartDate" },
                values: new object[] { new DateTime(2024, 5, 30, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 30, 15, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.UpdateData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 34,
                columns: new[] { "EndDate", "ReservationDate", "StartDate", "Status" },
                values: new object[] { new DateTime(2024, 5, 31, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 5, 31, 18, 0, 0, 0, DateTimeKind.Unspecified), 2 });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(796), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(779), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(730), new DateTime(2024, 7, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(784), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(799) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(806), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(803), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(801), new DateTime(2024, 6, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(804), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(807) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(814), new DateTime(2024, 3, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(810), new DateTime(2024, 3, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(809), new DateTime(2024, 4, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(812), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(815) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "ActivateOnDate", "ActivationDate", "CreatedAt", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(821), new DateTime(2024, 3, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(818), new DateTime(2024, 3, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(816), new DateTime(2024, 4, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(819), new DateTime(2024, 5, 15, 13, 39, 40, 887, DateTimeKind.Local).AddTicks(822) });
        }
    }
}
