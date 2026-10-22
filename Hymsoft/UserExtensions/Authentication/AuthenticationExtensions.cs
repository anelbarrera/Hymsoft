using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace UserExtensions
{
    public static class AuthenticationExtensions
    {
        // To be called in Startup.ConfigureServices, for adding services related with the authentication module
        public static IServiceCollection AddPowerServerAuthentication(
            this IServiceCollection services, IConfiguration configuration)
        {
            //The current template does not provide authentication service. If you want to use authentication service, change to another template
            return services;
        }
    }
}
