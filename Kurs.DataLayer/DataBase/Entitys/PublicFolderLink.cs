using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Kurs.DataLayer.DataBase.Entitys
{
    public class PublicFolderLink
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string FolderId { get; set; }

        [NotMapped]
        public string GetLink
        {
            get
            {
                var code = HttpUtility.UrlEncode( Generator.GenerateLinkCode());
                Code=code;
                var link = $"https://46.147.101.168:15577/PublicFolder/{code}";
                return link;
            }
        }
    }

    public static class Generator
    {
        public static string GenerateLinkCode()
        {
            var cd1 = Guid.NewGuid().ToString();
            var cd2 = Guid.NewGuid().ToString();
            SymmetricAlgorithm algorithm = DES.Create();
            byte[] key = Encoding.Unicode.GetBytes(cd1);
            ICryptoTransform transform = algorithm.CreateEncryptor(key,key);
            byte[] input = Encoding.Unicode.GetBytes(cd1);
            byte[] output = transform.TransformFinalBlock(input, 0, input.Length);
            return Convert.ToBase64String(output);
        }
    }
}
