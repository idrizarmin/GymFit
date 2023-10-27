using GymFit.Core;

namespace GymFit.Application
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<UserDto, User>().ReverseMap();

            CreateMap<User, UserSensitiveDto>();



            CreateMap<UserUpsertDto, User>()
                .ForMember(u => u.Photo, o => o.Ignore())
                .ForMember(u => u.IsVerified, o => o.MapFrom(_ => false))
                .ForMember(u => u.IsActive, o => o.MapFrom(_ => true));
        }
    }
}
