using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Models;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data
{
    /// <summary>
    /// Application database per tenant.
    /// </summary>
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        private readonly IApplicationDbContextConfigurator _configurator;

        public ApplicationDbContext(
            DbContextOptions<ApplicationDbContext> options,
            IApplicationDbContextConfigurator configurator)
            : base(options)
        {
            _configurator = configurator;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);

            _configurator.Configure(optionsBuilder);
        }
    }
}
