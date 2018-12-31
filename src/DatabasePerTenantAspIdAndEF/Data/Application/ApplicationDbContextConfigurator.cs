using System;
using Microsoft.EntityFrameworkCore;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Models;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data
{
    public class ApplicationDbContextConfigurator : IApplicationDbContextConfigurator
    {
        private readonly ITenancyContext<ApplicationTenant> _tenancyContext;

        public ApplicationDbContextConfigurator(ITenancyContext<ApplicationTenant> tenancyContext)
        {
            _tenancyContext = tenancyContext;
        }

        public void Configure(DbContextOptionsBuilder optionsBuilder)
        {
            var tenant = _tenancyContext?.Tenant;
            if (tenant == null)
            {
                //return; // uncomment when generating migrations
                throw new InvalidOperationException("Current tenant not found.");
            }

            // TODO: this could be extracted into an IApplicationDbContextFactory and registered in Startup.cs
            // which would create a properly configured context with a DbContextOptionsBuilder passed into the
            // constructor of the context rather than re-configuring it through the OnConfiguring override

            var options = optionsBuilder.Options.FindExtension<Microsoft.EntityFrameworkCore.Sqlite.Infrastructure.Internal.SqliteOptionsExtension>();
            if (options == null)
            {
                //return; // uncomment when generating migrations
                throw new InvalidOperationException("SQLite databse options not found. If using a different database server then you must find its options instead in the code above.");
            }

            var connectionString = options.ConnectionString.Replace("{{DATABASE_NAME}}", tenant.DatabaseName);
            optionsBuilder.UseSqlite(connectionString);
        }
    }
}
