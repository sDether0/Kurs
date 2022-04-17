using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;

namespace Kurs.DataLayer.DataBase.Entitys
{
    public class PublicFolder
    {
        public int Id { get; set; }
        public string FolderGuid { get; set; }
        public string UserGuid { get; set; }

        public virtual FIdentityUser User { get; set; }
    }


    public class FIdentityUser : IdentityUser
    {
        public virtual ICollection<PublicFolder> PublicFolders { get; set; }
    }
}
