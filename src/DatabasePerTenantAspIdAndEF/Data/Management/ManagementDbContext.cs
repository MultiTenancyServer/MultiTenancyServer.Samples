using Microsoft.EntityFrameworkCore;
using MultiTenancyServer.EntityFramework;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Models;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data
{
    /// <summary>
    /// Central database to manage tenants.
    /// </summary>
    public class ManagementDbContext : DbContext, ITenantDbContext<ApplicationTenant, string>
    {
        public ManagementDbContext(
            DbContextOptions<ManagementDbContext> options)
            : base(options)
        {
        }

        // MultiTenancyServer implementation.
        public DbSet<ApplicationTenant> Tenants { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // MultiTenancyServer configuration.
            var tenantStoreOptions = new TenantStoreOptions();
            builder.ConfigureTenantContext<ApplicationTenant, string>(tenantStoreOptions);

            // Configure custom properties on ApplicationTenant.
            builder.Entity<ApplicationTenant>(b =>
            {
                b.Property(t => t.DisplayName).HasMaxLength(256);
                b.Property(t => t.DatabaseName).HasMaxLength(256);
            });
        }
    }
}
