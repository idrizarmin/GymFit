using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class editPhoto : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "ThumbnailContent",
                table: "Photos",
                type: "varbinary(max)",
                nullable: false,
                defaultValue: new byte[0]);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ThumbnailContent",
                table: "Photos");
        }
    }
}
