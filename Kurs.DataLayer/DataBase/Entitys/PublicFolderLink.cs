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
                var code = HttpUtility.UrlDecode(Generator.GenerateLinkCode().Trim().Replace(" ",""));
                Code=code;
                var link = $"https://46.147.208.82:15577/PublicFolder/{HttpUtility.UrlEncode(code)}";
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
            var IV = Guid.NewGuid().ToString();
            SymmetricAlgorithm algorithm = Aes.Create();
            byte[] key = Encoding.Unicode.GetBytes(cd1);
            byte[] IVkey = Encoding.Unicode.GetBytes(IV);
            ICryptoTransform transform = algorithm.CreateEncryptor(key.Take(32).ToArray(),IVkey.Take(16).ToArray());
            byte[] input = Encoding.Unicode.GetBytes(cd2+cd1+IV);
            byte[] output = transform.TransformFinalBlock(input, 0, input.Length);
            return Convert.ToBase64String(output);
        }
    }
}
