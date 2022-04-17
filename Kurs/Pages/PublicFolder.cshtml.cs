using System.Text.Encodings.Web;
using System.Web;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Kurs.Pages
{
    public class PublicFolderModel : PageModel
    {

        public string _code { get; set; }
        [BindProperty]
        public string Email { get; set; }
        public IActionResult OnGet(string code)
        {
            _code = code;
            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (string.IsNullOrWhiteSpace(Email)) return Page();
            var handler = new HttpClientHandler();
            handler.ClientCertificateOptions = ClientCertificateOption.Manual;
            handler.ServerCertificateCustomValidationCallback =
                (httpRequestMessage, cert, cetChain, policyErrors) =>
                {
                    return true;
                };
            HttpClient client = new HttpClient(handler);
            
            var email = HttpUtility.UrlEncode(Email);
            await client.PostAsync($"https://46.147.101.168:15577/PublicFolder/{_code}/{email}", null);

            return Redirect("https://google.com");
        }
    }
}
