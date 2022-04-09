using AutoMapper;
using KursModels.Respones;
using Microsoft.AspNetCore.Identity;

namespace Kurs.Models
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<IdentityUser,UserDto>();
        }
    }
}
