using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Kurs.DataLayer.DataBase
{
    public class Migrate : IDesignTimeDbContextFactory<ApiDbContext>
    {
        public ApiDbContext CreateDbContext(string[] args)
        {
            var options = new DbContextOptionsBuilder<ApiDbContext>();
            options.UseNpgsql("User ID=postgres;Password=1namQfeg1;Host=localhost;Port=5432;Database=Kurs;");
            return new ApiDbContext(options.Options);
        }
    }
}
