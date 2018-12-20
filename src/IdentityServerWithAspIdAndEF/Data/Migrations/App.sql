CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" TEXT NOT NULL CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY,
    "ProductVersion" TEXT NOT NULL
);

CREATE TABLE "ApiResources" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiResources" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Created" TEXT NOT NULL,
    "Updated" TEXT NULL,
    "LastAccessed" TEXT NULL,
    "NonEditable" INTEGER NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "AspNetRoles" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_AspNetRoles" PRIMARY KEY,
    "Name" TEXT NULL,
    "NormalizedName" TEXT NULL,
    "ConcurrencyStamp" TEXT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "AspNetUsers" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_AspNetUsers" PRIMARY KEY,
    "UserName" TEXT NULL,
    "NormalizedUserName" TEXT NULL,
    "Email" TEXT NULL,
    "NormalizedEmail" TEXT NULL,
    "EmailConfirmed" INTEGER NOT NULL,
    "PasswordHash" TEXT NULL,
    "SecurityStamp" TEXT NULL,
    "ConcurrencyStamp" TEXT NULL,
    "PhoneNumber" TEXT NULL,
    "PhoneNumberConfirmed" INTEGER NOT NULL,
    "TwoFactorEnabled" INTEGER NOT NULL,
    "LockoutEnd" TEXT NULL,
    "LockoutEnabled" INTEGER NOT NULL,
    "AccessFailedCount" INTEGER NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "Clients" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Clients" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "ClientId" TEXT NOT NULL,
    "ProtocolType" TEXT NOT NULL,
    "RequireClientSecret" INTEGER NOT NULL,
    "ClientName" TEXT NULL,
    "Description" TEXT NULL,
    "ClientUri" TEXT NULL,
    "LogoUri" TEXT NULL,
    "RequireConsent" INTEGER NOT NULL,
    "AllowRememberConsent" INTEGER NOT NULL,
    "AlwaysIncludeUserClaimsInIdToken" INTEGER NOT NULL,
    "RequirePkce" INTEGER NOT NULL,
    "AllowPlainTextPkce" INTEGER NOT NULL,
    "AllowAccessTokensViaBrowser" INTEGER NOT NULL,
    "FrontChannelLogoutUri" TEXT NULL,
    "FrontChannelLogoutSessionRequired" INTEGER NOT NULL,
    "BackChannelLogoutUri" TEXT NULL,
    "BackChannelLogoutSessionRequired" INTEGER NOT NULL,
    "AllowOfflineAccess" INTEGER NOT NULL,
    "IdentityTokenLifetime" INTEGER NOT NULL,
    "AccessTokenLifetime" INTEGER NOT NULL,
    "AuthorizationCodeLifetime" INTEGER NOT NULL,
    "ConsentLifetime" INTEGER NULL,
    "AbsoluteRefreshTokenLifetime" INTEGER NOT NULL,
    "SlidingRefreshTokenLifetime" INTEGER NOT NULL,
    "RefreshTokenUsage" INTEGER NOT NULL,
    "UpdateAccessTokenClaimsOnRefresh" INTEGER NOT NULL,
    "RefreshTokenExpiration" INTEGER NOT NULL,
    "AccessTokenType" INTEGER NOT NULL,
    "EnableLocalLogin" INTEGER NOT NULL,
    "IncludeJwtId" INTEGER NOT NULL,
    "AlwaysSendClientClaims" INTEGER NOT NULL,
    "ClientClaimsPrefix" TEXT NULL,
    "PairWiseSubjectSalt" TEXT NULL,
    "Created" TEXT NOT NULL,
    "Updated" TEXT NULL,
    "LastAccessed" TEXT NULL,
    "UserSsoLifetime" INTEGER NULL,
    "UserCodeType" TEXT NULL,
    "DeviceCodeLifetime" INTEGER NOT NULL,
    "NonEditable" INTEGER NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "DeviceCodes" (
    "DeviceCode" TEXT NOT NULL,
    "UserCode" TEXT NOT NULL CONSTRAINT "PK_DeviceCodes" PRIMARY KEY,
    "SubjectId" TEXT NULL,
    "ClientId" TEXT NOT NULL,
    "CreationTime" TEXT NOT NULL,
    "Expiration" TEXT NOT NULL,
    "Data" TEXT NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "IdentityResources" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_IdentityResources" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Required" INTEGER NOT NULL,
    "Emphasize" INTEGER NOT NULL,
    "ShowInDiscoveryDocument" INTEGER NOT NULL,
    "Created" TEXT NOT NULL,
    "Updated" TEXT NULL,
    "NonEditable" INTEGER NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "PersistedGrants" (
    "Key" TEXT NOT NULL CONSTRAINT "PK_PersistedGrants" PRIMARY KEY,
    "Type" TEXT NOT NULL,
    "SubjectId" TEXT NULL,
    "ClientId" TEXT NOT NULL,
    "CreationTime" TEXT NOT NULL,
    "Expiration" TEXT NULL,
    "Data" TEXT NOT NULL,
    "TenantId" TEXT NOT NULL
);

CREATE TABLE "Tenants" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Tenants" PRIMARY KEY,
    "CanonicalName" TEXT NULL,
    "NormalizedCanonicalName" TEXT NULL,
    "ConcurrencyStamp" TEXT NULL,
    "DisplayName" TEXT NULL
);

CREATE TABLE "ApiClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiClaims_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiProperties_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiScopes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopes" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "DisplayName" TEXT NULL,
    "Description" TEXT NULL,
    "Required" INTEGER NOT NULL,
    "Emphasize" INTEGER NOT NULL,
    "ShowInDiscoveryDocument" INTEGER NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    "TenantId" TEXT NOT NULL,
    CONSTRAINT "FK_ApiScopes_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiSecrets" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiSecrets" PRIMARY KEY AUTOINCREMENT,
    "Description" TEXT NULL,
    "Value" TEXT NOT NULL,
    "Expiration" TEXT NULL,
    "Type" TEXT NOT NULL,
    "Created" TEXT NOT NULL,
    "ApiResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiSecrets_ApiResources_ApiResourceId" FOREIGN KEY ("ApiResourceId") REFERENCES "ApiResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY AUTOINCREMENT,
    "RoleId" TEXT NOT NULL,
    "ClaimType" TEXT NULL,
    "ClaimValue" TEXT NULL,
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY AUTOINCREMENT,
    "UserId" TEXT NOT NULL,
    "ClaimType" TEXT NULL,
    "ClaimValue" TEXT NULL,
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" TEXT NOT NULL,
    "ProviderKey" TEXT NOT NULL,
    "ProviderDisplayName" TEXT NULL,
    "UserId" TEXT NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" TEXT NOT NULL,
    "RoleId" TEXT NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" TEXT NOT NULL,
    "LoginProvider" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "Value" TEXT NULL,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientClaims_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientCorsOrigins" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientCorsOrigins" PRIMARY KEY AUTOINCREMENT,
    "Origin" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientCorsOrigins_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientGrantTypes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientGrantTypes" PRIMARY KEY AUTOINCREMENT,
    "GrantType" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientGrantTypes_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientIdPRestrictions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientIdPRestrictions" PRIMARY KEY AUTOINCREMENT,
    "Provider" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientIdPRestrictions_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientPostLogoutRedirectUris" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientPostLogoutRedirectUris" PRIMARY KEY AUTOINCREMENT,
    "PostLogoutRedirectUri" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientPostLogoutRedirectUris_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientProperties_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientRedirectUris" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientRedirectUris" PRIMARY KEY AUTOINCREMENT,
    "RedirectUri" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientRedirectUris_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientScopes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientScopes" PRIMARY KEY AUTOINCREMENT,
    "Scope" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientScopes_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ClientSecrets" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ClientSecrets" PRIMARY KEY AUTOINCREMENT,
    "Description" TEXT NULL,
    "Value" TEXT NOT NULL,
    "Expiration" TEXT NULL,
    "Type" TEXT NOT NULL,
    "Created" TEXT NOT NULL,
    "ClientId" INTEGER NOT NULL,
    CONSTRAINT "FK_ClientSecrets_Clients_ClientId" FOREIGN KEY ("ClientId") REFERENCES "Clients" ("Id") ON DELETE CASCADE
);

CREATE TABLE "IdentityClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_IdentityClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "IdentityResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_IdentityClaims_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "IdentityProperties" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_IdentityProperties" PRIMARY KEY AUTOINCREMENT,
    "Key" TEXT NOT NULL,
    "Value" TEXT NOT NULL,
    "IdentityResourceId" INTEGER NOT NULL,
    CONSTRAINT "FK_IdentityProperties_IdentityResources_IdentityResourceId" FOREIGN KEY ("IdentityResourceId") REFERENCES "IdentityResources" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ApiScopeClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_ApiScopeClaims" PRIMARY KEY AUTOINCREMENT,
    "Type" TEXT NOT NULL,
    "ApiScopeId" INTEGER NOT NULL,
    CONSTRAINT "FK_ApiScopeClaims_ApiScopes_ApiScopeId" FOREIGN KEY ("ApiScopeId") REFERENCES "ApiScopes" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_ApiClaims_ApiResourceId" ON "ApiClaims" ("ApiResourceId");

CREATE INDEX "IX_ApiProperties_ApiResourceId" ON "ApiProperties" ("ApiResourceId");

CREATE INDEX "IX_ApiResources_Name" ON "ApiResources" ("Name");

CREATE UNIQUE INDEX "IX_ApiResources_TenantId_Name" ON "ApiResources" ("TenantId", "Name");

CREATE INDEX "IX_ApiScopeClaims_ApiScopeId" ON "ApiScopeClaims" ("ApiScopeId");

CREATE INDEX "IX_ApiScopes_ApiResourceId" ON "ApiScopes" ("ApiResourceId");

CREATE INDEX "IX_ApiScopes_Name" ON "ApiScopes" ("Name");

CREATE UNIQUE INDEX "IX_ApiScopes_TenantId_Name" ON "ApiScopes" ("TenantId", "Name");

CREATE INDEX "IX_ApiSecrets_ApiResourceId" ON "ApiSecrets" ("ApiResourceId");

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE UNIQUE INDEX "TenantRoleNameIndex" ON "AspNetRoles" ("TenantId", "NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

CREATE UNIQUE INDEX "TenantUserNameIndex" ON "AspNetUsers" ("TenantId", "NormalizedUserName");

CREATE INDEX "IX_ClientClaims_ClientId" ON "ClientClaims" ("ClientId");

CREATE INDEX "IX_ClientCorsOrigins_ClientId" ON "ClientCorsOrigins" ("ClientId");

CREATE INDEX "IX_ClientGrantTypes_ClientId" ON "ClientGrantTypes" ("ClientId");

CREATE INDEX "IX_ClientIdPRestrictions_ClientId" ON "ClientIdPRestrictions" ("ClientId");

CREATE INDEX "IX_ClientPostLogoutRedirectUris_ClientId" ON "ClientPostLogoutRedirectUris" ("ClientId");

CREATE INDEX "IX_ClientProperties_ClientId" ON "ClientProperties" ("ClientId");

CREATE INDEX "IX_ClientRedirectUris_ClientId" ON "ClientRedirectUris" ("ClientId");

CREATE INDEX "IX_Clients_ClientId" ON "Clients" ("ClientId");

CREATE UNIQUE INDEX "IX_Clients_TenantId_ClientId" ON "Clients" ("TenantId", "ClientId");

CREATE INDEX "IX_ClientScopes_ClientId" ON "ClientScopes" ("ClientId");

CREATE INDEX "IX_ClientSecrets_ClientId" ON "ClientSecrets" ("ClientId");

CREATE INDEX "IX_DeviceCodes_DeviceCode" ON "DeviceCodes" ("DeviceCode");

CREATE UNIQUE INDEX "IX_DeviceCodes_TenantId_DeviceCode" ON "DeviceCodes" ("TenantId", "DeviceCode");

CREATE INDEX "IX_IdentityClaims_IdentityResourceId" ON "IdentityClaims" ("IdentityResourceId");

CREATE INDEX "IX_IdentityProperties_IdentityResourceId" ON "IdentityProperties" ("IdentityResourceId");

CREATE INDEX "IX_IdentityResources_Name" ON "IdentityResources" ("Name");

CREATE UNIQUE INDEX "IX_IdentityResources_TenantId_Name" ON "IdentityResources" ("TenantId", "Name");

CREATE INDEX "IX_PersistedGrant_TenantId" ON "PersistedGrants" ("TenantId");

CREATE INDEX "IX_PersistedGrants_SubjectId_ClientId_Type" ON "PersistedGrants" ("SubjectId", "ClientId", "Type");

CREATE UNIQUE INDEX "CanonicalNameIndex" ON "Tenants" ("NormalizedCanonicalName");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20181220071158_App', '2.1.4-rtm-31024');

