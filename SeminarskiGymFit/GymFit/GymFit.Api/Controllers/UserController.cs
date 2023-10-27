using AutoMapper;
using GymFit.Api.Models;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class UserController : BaseCrudController<UserDto, UserUpsertDto, BaseSearchObject, IUserService>
    {
        private readonly IMapper _mapper;
        public UserController(IMapper mapper, IUserService service, ILogger<UserController> logger) : base(service, logger)
        {
            _mapper = mapper;
        }
        [NonAction]
        public override Task<IActionResult> Post(UserUpsertDto upsertDto, CancellationToken cancellationToken = default) => base.Post(upsertDto, cancellationToken);


        [HttpPost]
        public async Task<IActionResult> Post([FromForm] UserUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var upsertDto = _mapper.Map<UserUpsertDto>(model);
                if (model.ProfilePhoto != null)
                {
                    await using var memoryStream = new MemoryStream();
                    await model.ProfilePhoto.CopyToAsync(memoryStream, cancellationToken);
                    upsertDto.ProfilePhoto = new PhotoUpsertDto
                    {
                        Data = memoryStream.ToArray(),
                        ContentType = model.ProfilePhoto.ContentType
                    };
                }

                var user = await Service.AddAsync(upsertDto, cancellationToken);

                return Ok(user);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error while trying to get top users");
                return BadRequest();
            }
        }
    }
}
