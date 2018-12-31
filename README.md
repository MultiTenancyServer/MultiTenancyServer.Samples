[![Build status](https://ci.appveyor.com/api/projects/status/47phsuxevn2t87ik/branch/master?svg=true)](https://ci.appveyor.com/project/krispenner/multitenancyserver-samples/branch/master)
# MultiTenancyServer.Samples

See [MultiTenancyServer README](https://github.com/MultiTenancyServer/MultiTenancyServer).

All examples will register two tenants (tenant1 and tenant2) along with three users with one user registered in both tenants: alice in tenant1 and tenant2, bob only in tenant1, and chris only in tenant2. You should launch the project (as an exe) when debugging instead of IIS Express so the /seed command line argument is passed in which will generate the Sqlite database(s) in the project folder and populate with the above mentioned tenants and users. All user passwords are Pass123$.

## ASP.NET Core Identity and Entity Framework Core
Sample project: [AspNetIdentityAndEFCore](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/tree/master/src/AspNetIdentityAndEFCore)<br />
Components: ASP.NET Core Identity and Entity Framework Core<br/>
Database model: single database with tenancy shadow columns<br/>

## Int64 ASP.NET Core Identity and Entity Framework Core
Sample project: [Int64AspNetIdentityAndEFCore](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/tree/master/src/Int64AspNetIdentityAndEFCore)<br />
Components: ASP.NET Core Identity and Entity Framework Core<br/>
Database model: single database with tenancy shadow columns<br/>

## Identity Server 4
Sample project: [IdentityServerWithAspIdAndEF](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/tree/master/src/IdentityServerWithAspIdAndEF)<br />
Components: Identity Server 4, ASP.NET Core Identity and Entity Framework Core<br/>
Database model: single database with tenancy shadow columns<br/>

## Database per tenant
Sample project: [DatabasePerTenantAspIdAndEF](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/tree/master/src/DatabasePerTenantAspIdAndEF)<br />
Components: ASP.NET Core Identity and Entity Framework Core<br/>
Database model: database per tenant<br/>
