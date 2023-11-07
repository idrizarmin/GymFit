using AutoMapper;
using GymFit.Api.Models;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class UserController : BaseCrudController<UserDto, UserUpsertDto, UserSearchObject, IUserService>
    {
        private readonly IMapper _mapper;
        public UserController(IMapper mapper, IUserService service, ILogger<UserController> logger) : base(service, logger)
        {
            _mapper = mapper;
        }
        [NonAction]
        public override Task<IActionResult> Post(UserUpsertDto upsertDto, CancellationToken cancellationToken = default) => base.Post(upsertDto, cancellationToken);

        [HttpGet("GetUsersForSelection")]
        public async Task<IActionResult> GetUsersForSelection(CancellationToken cancellationToken)
        {
            try
            {
                var dto= await Service.GetUserForSelectionAsync(cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        } 
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
                    upsertDto.profilePhoto = new PhotoUpsertDto
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
