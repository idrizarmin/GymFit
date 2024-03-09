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
        private readonly IPhotosService _photosService;
        public UserController(IMapper mapper, IUserService service, IPhotosService photosService, ILogger<UserController> logger) : base(service, logger)
        {
            _mapper = mapper;
            _photosService = photosService;
        }
        [NonAction]
        public override Task<IActionResult> Post(UserUpsertDto upsertDto, CancellationToken cancellationToken = default) => base.Post(upsertDto, cancellationToken);
        [NonAction]
        public override Task<IActionResult> Put(UserUpsertDto upsertDto, CancellationToken cancellationToken = default) => base.Put(upsertDto, cancellationToken);


        [HttpGet("GetCountUsers")]
        public async Task<IActionResult> GetCountOfUsers(CancellationToken cancellationToken)
        {
            try
            {
                var result = await Service.getCountOfUsersAsync(cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpGet("GetCountActiveUsers")]
        public async Task<IActionResult> GetCountOfActiveUsers(CancellationToken cancellationToken)
        {
            try
            {
                var result = await Service.getCountOfUsersActiveAsync(cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpGet("GetCountInactiveUsers")]
        public async Task<IActionResult> GetCountOfInActiveUsers(CancellationToken cancellationToken)
        {
            try
            {
                var result = await Service.getCountOfUsersInactiveAsync(cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
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

        [HttpGet("GetAllTrainers")]
        public async Task<IActionResult> GetAllTrainers(CancellationToken cancellationToken)
        {
            try
            {
                var dto = await Service.GetAllTrainersAsync(cancellationToken);
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
        public async Task<IActionResult> Post([FromForm]UserUpsertModel model, CancellationToken cancellationToken = default)
          {
            try
            {
                var upsertDto = _mapper.Map<UserUpsertDto>(model);

                if (model.ProfilePhoto != null && model.ProfilePhoto.Length > 0)
                {
                    var formFile = model.ProfilePhoto;
                    using (var memoryStream = new MemoryStream())
                    {
                        await formFile.CopyToAsync(memoryStream);
                        var photoData = memoryStream.ToArray();

                        var photoInputModel = new PhotoInputModel
                        {
                            FileName = formFile.FileName,
                            Type = formFile.ContentType,
                            Content = formFile.OpenReadStream()
                        };

                        var guidId  =  await _photosService.ProcessAsync(new List<PhotoInputModel> { photoInputModel });

                        var photoId = await _photosService.getPhotoIdAsync(guidId[0], cancellationToken);    

                        upsertDto.photoId = photoId;
                    }
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
        public async Task<IActionResult> Put([FromForm]UserUpsertModel model, CancellationToken cancellationToken = default)
        {
            try
            {
                var upsertDto = _mapper.Map<UserUpsertDto>(model);

                if (model.ProfilePhoto != null && model.ProfilePhoto.Length > 0)
                {
                    var formFile = model.ProfilePhoto;
                    using (var memoryStream = new MemoryStream())
                    {
                        await formFile.CopyToAsync(memoryStream);
                        var photoData = memoryStream.ToArray();

                        var photoInputModel = new PhotoInputModel
                        {
                            FileName = formFile.FileName,
                            Type = formFile.ContentType,
                            Content = formFile.OpenReadStream()
                        };

                        var guidId = await _photosService.ProcessAsync(new List<PhotoInputModel> { photoInputModel });

                        var photoId = await _photosService.getPhotoIdAsync(guidId[0], cancellationToken);

                        upsertDto.photoId = photoId;
                    }
                }
                else
                {

                   var user = await Service.GetByIdAsync(model.Id, cancellationToken);

                    upsertDto.photoId = (int)user.PhotoId;
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

        [HttpGet("Recommended/{id}")]
        public  List<UserDto> Recommend(int id)
        {
            return Service.Recommend(id);  
        }

    }
}
