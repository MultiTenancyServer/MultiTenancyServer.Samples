[![Build status](https://ci.appveyor.com/api/projects/status/47phsuxevn2t87ik/branch/master?svg=true)](https://ci.appveyor.com/project/krispenner/multitenancyserver-samples/branch/master)
# MultiTenancyServer.Samples

See [MultiTenancyServer README](https://github.com/MultiTenancyServer/MultiTenancyServer).

## ASP.NET Core Identity and Entity Framework Core
[Sample project](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/tree/master/src/AspNetIdentityAndEFCore)

[Add multi-tenancy commit/diff](https://github.com/MultiTenancyServer/MultiTenancyServer.Samples/commit/0dabd345473d64a58b5ccf72cd8de6766d0b7969#diff-5402c86148335f8194c6a85d5fffe6dd)

This example will register two tenants (tenant1 and tenant2) along with three users with one user registered in both tenants: alice in tenant1 and tenant2, bob only in tenant1, and chris only in tenant2. You should launch the project (as an exe) when debugging instead of IIS Express so the /seed command line argument is passed in which will generate the Sqlite database in the project folder and populate with the above mentioned tenants and users. All user passwords are Pass123$.
