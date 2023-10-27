using GymFit.Core;

namespace GymFit.Application
{
    public class ClientProgresProfile : BaseProfile
    {
        public ClientProgresProfile() 
        {
            CreateMap<ClientProgresDto, ClientProgress>().ReverseMap();

            CreateMap<ClientProgresUpsertDto, ClientProgress>();
        }
    }
}
