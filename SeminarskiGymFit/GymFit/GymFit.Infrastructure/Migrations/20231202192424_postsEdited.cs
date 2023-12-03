using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GymFit.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class postsEdited : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Post_Photos_PhotoId",
                table: "Post");

            migrationBuilder.DropIndex(
                name: "IX_Post_PhotoId",
                table: "Post");

            migrationBuilder.DropColumn(
                name: "PhotoId",
                table: "Post");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PhotoId",
                table: "Post",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Post_PhotoId",
                table: "Post",
                column: "PhotoId");

            migrationBuilder.AddForeignKey(
                name: "FK_Post_Photos_PhotoId",
                table: "Post",
                column: "PhotoId",
                principalTable: "Photos",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
