using DmWebPlatform.Domain.Entities;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace DmWebPlatform.API
{
    public class SeedData
    {
        public static async Task Initialize(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            var userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();

            // Define the roles you want to create
            string[] roleNames = { "Admin", "Instructor", "User", "Guest" };

            // Seed roles
            foreach (var roleName in roleNames)
            {
                var roleExist = await roleManager.RoleExistsAsync(roleName);
                if (!roleExist)
                {
                    await roleManager.CreateAsync(new IdentityRole(roleName));
                }
            }

            // Seed the Admin user
            var adminUser = new ApplicationUser
            {
                UserName = "admin@domain.com",
                Email = "admin@domain.com"
            };

            string adminPassword = "AdminPassword123!";
            var existingAdminUser = await userManager.FindByEmailAsync(adminUser.Email);

            if (existingAdminUser == null)
            {
                // Create the admin user if it doesn't exist
                var createAdminUserResult = await userManager.CreateAsync(adminUser, adminPassword);
                if (createAdminUserResult.Succeeded)
                {
                    // Assign the Admin role to the created user
                    await userManager.AddToRoleAsync(adminUser.Id, "Admin");
                }
            }
        }
    }

}
