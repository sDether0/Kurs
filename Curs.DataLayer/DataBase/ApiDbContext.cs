using Kurs.DataLayer.DataBase.Entitys;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Kurs.DataLayer.DataBase
{
    public class ApiDbContext : IdentityDbContext
    {
        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options)
        {
            Database.EnsureCreated();
        }
        public virtual DbSet<RefreshToken> RefreshTokens { get; set; }
    }
}
