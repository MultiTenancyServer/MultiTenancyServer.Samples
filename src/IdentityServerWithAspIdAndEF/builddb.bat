del AspIdUsers.db
rmdir /S /Q Data\Migrations

dotnet ef migrations add App -c ApplicationDbContext -o Data/Migrations
dotnet ef migrations script -c ApplicationDbContext -o Data/Migrations/App.sql
dotnet ef database update -c ApplicationDbContext

dotnet run /seed
