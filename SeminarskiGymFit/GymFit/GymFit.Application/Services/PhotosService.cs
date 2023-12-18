using AutoMapper;
using Azure;
using FluentValidation;

using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using SixLabors.ImageSharp.Formats.Jpeg;

using static System.Net.Mime.MediaTypeNames;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Processing;


namespace GymFit.Application
{
    public class PhotosService : BaseService<Photo, PhotoDto, PhotoUpsertDto, BaseSearchObject, IPhotosRepository>, IPhotosService
    {
        private const int ThumbnailWidth = 155;
        public PhotosService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PhotoUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<List<Guid>> ProcessAsync(IEnumerable<PhotoInputModel> images)
        {
            var imageIds = new List<Guid>();

            foreach (var image in images)
            {
                using var imageResult = await SixLabors.ImageSharp.Image.LoadAsync(image.Content);

                var original = await SaveImageAsync(imageResult, imageResult.Width);
                var thumbnail = await SaveImageAsync(imageResult, ThumbnailWidth);

                //save to db
                var photo = new Photo
                {
                    ContentType = image.Type,
                    Data = original,
                    ThumbnailContent = thumbnail
                };

                await CurrentRepository.AddAsync(photo);
                await UnitOfWork.SaveChangesAsync();

                //var user = await UnitOfWork.UserRepository.GetByIdAsync(1);

                //user.PhotoId = photo.Id;

            }

            return imageIds;
        }

        private async Task<byte[]> SaveImageAsync(SixLabors.ImageSharp.Image image, int resizeWidth)
        {
            var width = image.Width;
            var height = image.Height;

            if (width > resizeWidth)
            {
                height = (int)((double)resizeWidth / width * height);
                width = resizeWidth;
            }

            image.Mutate(x => x.Resize(width, height));
            image.Metadata.ExifProfile = null;

            var memoryStream = new MemoryStream();

            await image.SaveAsJpegAsync(memoryStream, new JpegEncoder
            {
                Quality = 80
            });

            return memoryStream.ToArray();
        }

        public async Task<byte[]?> GetImageAsync(Guid id, bool original)
        {
            if (original)
            {
                return await CurrentRepository.GetOriginalContet(id);
            }

            return await CurrentRepository.GetThumbnailContent(id);
        }
    }
}
