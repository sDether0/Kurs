using Kurs.DataLayer.DataBase.Entitys;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Kurs.DataLayer.DataBase
{
    public class ApiDbContext : IdentityDbContext<FIdentityUser>
    {
        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options)
        {

        }
        public virtual DbSet<RefreshToken> RefreshTokens { get; set; }
        public virtual DbSet<PublicFolder> PublicFolders { get; set; }
        public virtual DbSet<PublicFolderLink> PublicFolderLinks { get; set; }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<PublicFolder>(entity =>
            {
                entity.HasOne(p => p.User)
                    .WithMany(d => d.PublicFolders)
                    .HasForeignKey(x=>x.UserGuid);
            });

            base.OnModelCreating(builder);
        }
    }
}
