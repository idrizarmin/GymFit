﻿using AutoMapper;
using GymFit.Application.Interfaces;
using GymFit.Common.Services;
using GymFit.Core;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace GymFit.Api
{
    public class AccessManager : IAccessManager
    {
        private readonly IMapper _mapper;
        private readonly ICryptoService _cryptoService;
        private readonly IUserService _usersService;
        private readonly JwtTokenConfig _jwtTokenConfig;
        public AccessManager(IMapper mapper, ICryptoService cryptoService, IUserService usersService, IOptions<JwtTokenConfig> jwtTokenConfig)
        {
            _mapper = mapper;
            _cryptoService = cryptoService;
            _usersService = usersService;
            _jwtTokenConfig = jwtTokenConfig.Value;
        }

        public async Task<AccessSignInResponseModel> SignInAsync(AccessSignInModel model, CancellationToken cancellationToken = default)
        {
            var user = await _usersService.GetByEmailAsync(model.Email, cancellationToken);
            if (user == null)
                throw new UserNotFoundException();

            if (!user.IsActive)
                throw new UserNotActiveException();

            if (!user.IsVerified)
                throw new UserNotVerifiedException();

            if (!_cryptoService.Verify(user.PasswordHash, user.PasswordSalt, model.Password))
                throw new UserWrongCredentialsException();

            return new AccessSignInResponseModel
            {
                Token = CreateToken(user)
            };
        }

        public async Task SignUpAsync(AccessSignUpModel model, CancellationToken cancellationToken = default)
        {
            var upsertDto = _mapper.Map<UserUpsertDto>(model);

            await _usersService.AddAsync(upsertDto, cancellationToken);
        }


        private string CreateToken(UserDto user)
        {
            var secretKey = Encoding.ASCII.GetBytes(_jwtTokenConfig.SecretKey);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimNames.Id, user.Id.ToString()),
                    new Claim(ClaimNames.FirstName, user.FirstName),
                    new Claim(ClaimNames.LastName, user.LastName),
                    new Claim(ClaimNames.Email, user.Email),
                    new Claim(ClaimNames.Role, user.Role.ToString())

                }),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(secretKey),
                    SecurityAlgorithms.HmacSha512Signature
                ),
                Issuer = _jwtTokenConfig.Issuer,
                Audience = _jwtTokenConfig.Audience,
                Expires = DateTime.UtcNow.AddMinutes(_jwtTokenConfig.Duration)
            };

            if (user.PhotoId != null)
                tokenDescriptor.Subject.AddClaim(new Claim(ClaimNames.PhotoId, user.PhotoId.Value.ToString()));

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}
