using Kurs.FilesIO.Models;

namespace Kurs.FilesIO.Models
{
    public class PublicFolderInfo
    {
        public string Name { get; set; }
        public string Guid { get; set; }
        public List<PathInfo> Paths { get; set; }
    }
}
