﻿using GymFit.Api.Models;
using GymFit.Application;
using GymFit.Core;

namespace GymFit.Api.Mapping
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<AccessSignUpModel, UserUpsertDto>()
                .ForMember(a => a.IsActive, o => o.MapFrom(s => true))
                .ForMember(a => a.IsVerified, o => o.MapFrom(s => true))
                .ForMember(a => a.Role, o => o.MapFrom(s => Role.Korisnik));

            CreateMap<UserUpsertModel, UserUpsertDto>()
            .ForMember(a => a.photoId, o => o.Ignore()
            );
        }
    }
}
