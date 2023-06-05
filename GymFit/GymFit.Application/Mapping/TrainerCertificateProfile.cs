using GymFit.Core;

namespace GymFit.Application
{
    public class TrainerCertificateProfile : BaseProfile
    {
        public TrainerCertificateProfile()
        {
            CreateMap<TrainerCertificateDto, TrainerCertificate>().ReverseMap();

            CreateMap<TrainerCertificateUpsertDto, TrainerCertificate>();
        }
    }
}
