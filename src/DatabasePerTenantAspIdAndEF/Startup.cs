using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Data;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Models;
using MultiTenancyServer.Samples.AspNetIdentityAndEFCore.Services;

namespace MultiTenancyServer.Samples.AspNetIdentityAndEFCore
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // Central database to manage tenants.
            // You could use the InMemoryTenantStore instead or your own custom store (such as from configuration).
            services.AddDbContext<ManagementDbContext>(options => options
                .UseSqlite(Configuration.GetConnectionString("ManagementConnection"))
                //.EnableSensitiveDataLogging()
                );

            // Application database per tenant.
            services.AddDbContext<ApplicationDbContext>(options => options
                .UseSqlite(Configuration.GetConnectionString("ApplicationConnection"))
                //.EnableSensitiveDataLogging()
                );

            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            // Add Multi-Tenancy services.
            services.AddMultiTenancy<ApplicationTenant, string>()
                // To test a domain parser locally, add a similar line 
                // to your hosts file for each tenant you want to test
                // For Windows: C:\Windows\System32\drivers\etc\hosts
                // 127.0.0.1	tenant1.tenants.local
                // 127.0.0.1	tenant2.tenants.local
                //parsers.AddSubdomainParser(".tenants.local");
                .AddChildPathParser("/tenants/")
                .AddEntityFrameworkStore<ManagementDbContext, ApplicationTenant, string>();

            // Add service to configure an ApplicationDbContext per tenant
            // TODO: this should be replaced with some sort of an IApplicationDbContextFactory
            services.AddTransient<IApplicationDbContextConfigurator, ApplicationDbContextConfigurator>();

            // Add application services.
            services.AddTransient<IEmailSender, EmailSender>();

            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Latest);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();

            app.UseStaticFiles();

            app.UseRouting();

            app.UseMultiTenancy<ApplicationTenant>();

            app.UseAuthentication();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    // if using a PathParser, you will need to adjust this to accomodate the tenant paths
                    pattern: "tenants/{_tenant_placeholder_}/{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
