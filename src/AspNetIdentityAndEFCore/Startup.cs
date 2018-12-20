using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
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
            services.AddDbContext<ApplicationDbContext>(options => options
                .UseSqlite(Configuration.GetConnectionString("DefaultConnection"))
                //.EnableSensitiveDataLogging()
                );

            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            // Add Multi-Tenancy services.
            services.AddMultiTenancy<ApplicationTenant, string>()
                .AddRequestParsers(parsers =>
                {
                    // To test a domain parser locally, add a similar line 
                    // to your hosts file for each tenant you want to test
                    // For Windows: C:\Windows\System32\drivers\etc\hosts
                    // 127.0.0.1	tenant1.tenants.local
                    // 127.0.0.1	tenant2.tenants.local
                    //parsers.AddSubdomainParser(".tenants.local");

                    parsers.AddChildPathParser("/tenants/");
                })
                .AddEntityFrameworkStore<ApplicationDbContext, ApplicationTenant, string>();

            // Add application services.
            services.AddTransient<IEmailSender, EmailSender>();

            services.AddMvc()
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
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

            app.UseAuthentication();

            app.UseMultiTenancy<ApplicationTenant>();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    // if using a PathParser, you will need to adjust this to accomodate the tenant paths
                    template: "tenants/{_tenant_placeholder_}/{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
