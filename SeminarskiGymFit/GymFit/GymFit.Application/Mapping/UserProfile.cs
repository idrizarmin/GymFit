using GymFit.Core;
using GymFit.Core.Dtos.User;

namespace GymFit.Application
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<UserDto, User>().ReverseMap();

            CreateMap<User, UserSensitiveDto>();

            CreateMap<User, UserForSelectionDto>();


            CreateMap<UserUpsertDto, User>()
                .ForMember(u => u.Photo, o => o.Ignore());
                
        }
    }
}
