//using System.Collections.Generic;
//using System.Linq;
//using GymFit.Application.Interfaces;
//using GymFit.Core;
//using Microsoft.ML;
//using Microsoft.ML.Data;
//using Microsoft.ML.Trainers;

//namespace GymFit.Application
//{
//    public class RecommendationService
//    {
//        private readonly MLContext _mlContext;
//        private ITransformer _model;
//        private readonly IReservationsService _reservationsService;

//        public RecommendationService()
//        {
//            _mlContext = new MLContext();
//        }

//        public List<RecommendedItem> GetRecommendations(List<Reservation> userReservations)
//        {
//            // Assuming your reservations include TrainerId and Description for workout information

//            // Preprocess the data into a format suitable for ML.NET
//            var data = userReservations
//                .Where(r => r.TrainerId != null && !string.IsNullOrEmpty(r.Description))
//                .Select(r => new ReservationEntry
//                {
//                    UserId = r.UserId,
//                    TrainerId = r.TrainerId.Value,
//                    WorkoutDescription = r.Description
//                })
//                .ToList();

//            if (data.Count < 2)
//                return new List<RecommendedItem>();

//            var trainData = _mlContext.Data.LoadFromEnumerable(data);

//            // Train the model if it's not already trained
//            if (_model == null)
//            {
//                var options = new MatrixFactorizationTrainer.Options
//                {
//                    MatrixColumnIndexColumnName = nameof(ReservationEntry.UserId),
//                    MatrixRowIndexColumnName = nameof(ReservationEntry.TrainerId),
//                    LabelColumnName = "Label",
//                    LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
//                    Alpha = 0.01,
//                    Lambda = 0.025,
//                    NumberOfIterations = 100,
//                    C = 0.00001
//                };

//                var trainer = _mlContext.Recommendation().Trainers.MatrixFactorization(options);
//                _model = trainer.Fit(trainData);
//            }

//            // Get recommendations
//            var userId = data.First().UserId;
//            var predictions = _model.Transform(trainData);
//            var recommendedItems = _mlContext.Data.CreateEnumerable<RecommendedItem>(predictions, reuseRowObject: false)
//                .Where(x => x.UserId == userId)
//                .OrderByDescending(x => x.Score)
//                .Select(x => new RecommendedItem { TrainerId = x.TrainerId, Score = x.Score })
//                .ToList();

//            return recommendedItems;
//        }

//        public class ReservationEntry
//        {
//            [KeyType(count: 10)]
//            public uint UserId { get; set; }

//            [KeyType(count: 10)]
//            public uint TrainerId { get; set; }

//            public string WorkoutDescription { get; set; }

//            public float Label { get; set; }
//        }

//        public class RecommendedItem
//        {
//            public uint TrainerId { get; set; }

//            public float Score { get; set; }
//        }
//    }
//}
