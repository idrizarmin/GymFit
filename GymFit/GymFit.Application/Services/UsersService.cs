using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Common.Services;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class UsersService : BaseService<User, UserDto, UserUpsertDto, BaseSearchObject, IUserRepository>, IUserService
    {
        private readonly ICryptoService _cryptoService;

        public UsersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserUpsertDto> validator, ICryptoService cryptoService) : base(mapper, unitOfWork, validator)
        {
            _cryptoService = cryptoService;
        }
        public async Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByEmailAsync(email, cancellationToken);
            return Mapper.Map<UserSensitiveDto>(user);
        }


    }
}
