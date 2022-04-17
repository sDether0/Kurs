using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurs.FilesIO.Interfaces
{
    public interface IPublicFolder
    {
        Task<string> CreatePublicFolder();
    }
}
