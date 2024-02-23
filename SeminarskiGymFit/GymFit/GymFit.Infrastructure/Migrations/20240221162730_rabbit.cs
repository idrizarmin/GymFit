using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class rabbit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 1,
                column: "SendOnDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7058));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 2,
                column: "SendOnDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7061));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 3,
                column: "SendOnDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7064));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 4,
                column: "SendOnDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7067));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7086));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7089));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7091));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7093));

            migrationBuilder.InsertData(
                table: "Reservations",
                columns: new[] { "Id", "CreatedAt", "DaysOfWeek", "Description", "Duration", "EndDate", "GymId", "MaxCapacity", "ModifiedAt", "PauseDuration", "ReservationDate", "StartDate", "Status", "TrainerId", "UserId", "isUsed" },
                values: new object[,]
                {
                    { 17, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 2, 7, 10, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 2, 7, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 2, 7, 9, 0, 0, 0, DateTimeKind.Unspecified), 1, 3, 5, false },
                    { 18, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 1, 26, 22, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 1, 26, 21, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 1, 26, 21, 0, 0, 0, DateTimeKind.Unspecified), 1, 2, 5, false },
                    { 19, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 1, 15, 21, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 1, 15, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 1, 15, 20, 0, 0, 0, DateTimeKind.Unspecified), 3, 2, 5, false },
                    { 20, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Pilates", null, new DateTime(2024, 1, 14, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, null, null, null, new DateTime(2024, 1, 14, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2024, 1, 14, 19, 0, 0, 0, DateTimeKind.Unspecified), 4, 2, 5, true }
                });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7010), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(6955), new DateTime(2024, 4, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7002), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7013) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7019), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7016), new DateTime(2024, 3, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7017), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7021) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7026), new DateTime(2023, 12, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7022), new DateTime(2024, 1, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7024), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7028) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7033), new DateTime(2023, 12, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7029), new DateTime(2024, 1, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7031), new DateTime(2024, 2, 21, 17, 27, 28, 949, DateTimeKind.Local).AddTicks(7034) });

            migrationBuilder.CreateIndex(
                name: "IX_NotificationsRabbit_UserId",
                table: "NotificationsRabbit",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "NotificationsRabbit");

            migrationBuilder.DeleteData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Reservations",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 1,
                column: "SendOnDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3052));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 2,
                column: "SendOnDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3055));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 3,
                column: "SendOnDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3057));

            migrationBuilder.UpdateData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 4,
                column: "SendOnDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3059));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 1,
                column: "PublishDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3072));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 2,
                column: "PublishDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3074));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 3,
                column: "PublishDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3075));

            migrationBuilder.UpdateData(
                table: "Post",
                keyColumn: "Id",
                keyValue: 4,
                column: "PublishDate",
                value: new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3077));

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3014), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(2980), new DateTime(2024, 3, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3010), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3016) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3020), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3017), new DateTime(2024, 2, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3018), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3022) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3027), new DateTime(2023, 11, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3023), new DateTime(2023, 12, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3025), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3028) });

            migrationBuilder.UpdateData(
                table: "UserPackages",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "ActivateOnDate", "ActivationDate", "ExpirationDate", "PausedOnDate" },
                values: new object[] { new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3033), new DateTime(2023, 11, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3030), new DateTime(2023, 12, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3031), new DateTime(2024, 1, 8, 1, 59, 47, 876, DateTimeKind.Local).AddTicks(3034) });
        }
    }
}
