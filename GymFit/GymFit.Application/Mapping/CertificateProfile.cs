using GymFit.Core;

namespace GymFit.Application
{
    public class CertificateProfile : BaseProfile
    {
        public CertificateProfile()
        {
            CreateMap<CertificateDto, Certificates>().ReverseMap();

            CreateMap<CertificateUpsertDto, Certificates>();
        }
    }
}
