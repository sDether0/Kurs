using AutoMapper;
using Kurs.DataLayer.DataBase.Entitys;
using KursModels.Respones;
using Microsoft.AspNetCore.Identity;

namespace Kurs.Models
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<FIdentityUser, UserDto>();
        }
    }
}
