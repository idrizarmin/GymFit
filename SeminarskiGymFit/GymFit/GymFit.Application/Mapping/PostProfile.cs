﻿using GymFit.Core;

namespace GymFit.Application
{
    public class PostProfile : BaseProfile
    {
        public PostProfile() 
        {
            CreateMap<PostDto,Post>().ReverseMap();

            CreateMap<PostUpsertDto, Post>();

            
        }
    }
}
