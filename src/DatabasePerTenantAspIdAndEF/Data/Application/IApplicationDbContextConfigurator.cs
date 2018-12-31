using Microsoft.EntityFrameworkCore;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data
{
    public interface IApplicationDbContextConfigurator
    {
        void Configure(DbContextOptionsBuilder optionsBuilder);
    }
}
