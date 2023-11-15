using AutoMapper;
using GymFit.Api.Models;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Core.Dtos.User;
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
        [NonAction]
        public override Task<IActionResult> Put(UserUpsertDto upsertDto, CancellationToken cancellationToken = default) => base.Put(upsertDto, cancellationToken);
       
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
        [HttpGet("GetTrainersForSelection")]
        public async Task<IActionResult> GeTrainersForSelection(CancellationToken cancellationToken)
        {
            try
            {
                var dto = await Service.GetTrainersForSelectionAsync(cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpGet("GetAdminsPaged")]

        public async Task<IActionResult> GetAdminsPagedAsync([FromQuery] UserSearchObject searchObject, CancellationToken cancellationToken)
        {

            try
            {
                var dto = await Service.GetAdminsPagedAsync(searchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpGet("GetTrainersPaged")]

        public async Task<IActionResult> GetTrainersPagedAsync([FromQuery] UserSearchObject searchObject, CancellationToken cancellationToken)
        {

            try
            {
                var dto = await Service.GetTrainersPagedAsync(searchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }

        [HttpPost]
        public async Task<IActionResult> Post(UserUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var upsertDto = _mapper.Map<UserUpsertDto>(model);

                if (!string.IsNullOrEmpty(model.ProfilePhoto))
                {
                    byte[] photoData = Convert.FromBase64String(model.ProfilePhoto);

                    upsertDto.profilePhoto = new PhotoUpsertDto
                    {
                        Data = photoData,
                        ContentType = "image/png"
                    };
                }

                var user = await Service.AddAsync(upsertDto, cancellationToken);

                return Ok(user);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error while trying to add a user");
                return BadRequest();
            }
        }
        
        [HttpPut]
        public async Task<IActionResult> Put(UserUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var upsertDto = _mapper.Map<UserUpsertDto>(model);

                if (!string.IsNullOrEmpty(model.ProfilePhoto))
                {
                    byte[] photoData = Convert.FromBase64String(model.ProfilePhoto);

                    upsertDto.profilePhoto = new PhotoUpsertDto
                    {
                        Data = photoData,
                        ContentType = "image/png"
                    };
                }

                await Service.UpdateAsync(upsertDto, cancellationToken);

                return Ok(upsertDto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error while trying to get top users");
                return BadRequest();
            }
        }
        [HttpPut("ChangePassword")]
        public async Task<IActionResult> ChangepPassword([FromBody] UserChangePasswordDto dto, CancellationToken cancellationtoken = default)
        {
            try
            {
                await Service.ChangePassword(dto, cancellationtoken);
                return Ok();
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error while trying to change password!");
                return BadRequest();
            }
        }
    }
}
