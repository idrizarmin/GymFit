using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class editedGym : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Gyms_Citys_CityId",
                table: "Gyms");

            migrationBuilder.DropForeignKey(
                name: "FK_Gyms_Photos_PhotoId",
                table: "Gyms");

            migrationBuilder.AlterColumn<int>(
                name: "PhotoId",
                table: "Gyms",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "CityId",
                table: "Gyms",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Gyms_Citys_CityId",
                table: "Gyms",
                column: "CityId",
                principalTable: "Citys",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Gyms_Photos_PhotoId",
                table: "Gyms",
                column: "PhotoId",
                principalTable: "Photos",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Gyms_Citys_CityId",
                table: "Gyms");

            migrationBuilder.DropForeignKey(
                name: "FK_Gyms_Photos_PhotoId",
                table: "Gyms");

            migrationBuilder.AlterColumn<int>(
                name: "PhotoId",
                table: "Gyms",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "CityId",
                table: "Gyms",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Gyms_Citys_CityId",
                table: "Gyms",
                column: "CityId",
                principalTable: "Citys",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Gyms_Photos_PhotoId",
                table: "Gyms",
                column: "PhotoId",
                principalTable: "Photos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
