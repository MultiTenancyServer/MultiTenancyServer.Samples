using Microsoft.EntityFrameworkCore.Migrations;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data.Management.Migrations
{
    public partial class ManagementSchema : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Tenants",
                columns: table => new
                {
                    Id = table.Column<string>(nullable: false),
                    CanonicalName = table.Column<string>(maxLength: 256, nullable: true),
                    NormalizedCanonicalName = table.Column<string>(maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(nullable: true),
                    DisplayName = table.Column<string>(maxLength: 256, nullable: true),
                    DatabaseName = table.Column<string>(maxLength: 256, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tenants", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "CanonicalNameIndex",
                table: "Tenants",
                column: "NormalizedCanonicalName",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Tenants");
        }
    }
}
