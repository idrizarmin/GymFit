﻿using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Threading;

namespace GymFit.Api.Controllers
{
    public class PhotosController : BaseCrudController<PhotoDto, PhotoUpsertDto, BaseSearchObject, IPhotosService>
    {
        public PhotosController(IPhotosService service, ILogger<PhotosController> logger) : base(service, logger)
        {
        }

        [RequestSizeLimit(24 * 1024 * 1024)]
        [HttpPost("Add")]
        public async Task<ActionResult<List<Guid>>> Upload(IFormFile[] images)
        {
            if (images.Length == 0) return BadRequest("Slike nisu poslane");
            if (images.Length > 10)
            {
                return BadRequest("You cannot upload more than 10 images");
            }

            var imageIds = await Service.ProcessAsync(images.Select(i => new PhotoInputModel
            {
                FileName = i.FileName,
                Type = i.ContentType,
                Content = i.OpenReadStream()
            }));

            return Ok(imageIds);
        }

        [HttpGet("GetbyId")]
        public async Task<ActionResult> GetImage(Guid id, bool original = false)
        {
            try
            {
                var imageBytes = await Service.GetImageAsync(id, original);
                if (imageBytes == null) return BadRequest();

                return File(imageBytes, "image/jpeg");
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
    }
}
