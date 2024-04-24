using GymFit.Api;
using GymFit.Api.Controllers;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using Hangfire;
using Hangfire.SqlServer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using Stripe;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews()
                .AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");


builder.Services.AddMapper();
builder.Services.AddValidators();
builder.Services.AddApplication();
builder.Services.AddInfrastructure();
builder.Services.AddDatabase(connectionStringConfig);
builder.Services.AddAuthenticationAndAuthorization(jwtTokenConfig);
builder.Services.AddOther();
builder.Services.AddResponseCaching();
builder.Services.AddControllers();


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


builder.Services.AddHangfire(config => 
    config.UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseSqlServerStorage(builder.Configuration.GetConnectionString("Main"))
    );

//builder.Services.AddHangfire((sp, config) => {
//    var conString = sp.GetRequiredService<IConfiguration>().GetConnectionString("Main");
//    config.SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
//    .UseSimpleAssemblyNameTypeSerializer()
//    .UseRecommendedSerializerSettings()
//    .UseSqlServerStorage(conString, new SqlServerStorageOptions
//    {
//        PrepareSchemaIfNecessary = true
//    });

//});
builder.Services.AddHangfireServer();






builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});
builder.Services.AddCors(options =>
{
    options.AddPolicy("CorsPolicy",
        builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

builder.Services.Configure<ApiBehaviorOptions>(options => options.SuppressModelStateInvalidFilter = true);




if (builder.Environment.IsDevelopment())
{
    builder.Services.AddSwagger();
}

var app = builder.Build();




if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("CorsPolicy");

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();


app.UseHangfireDashboard();
app.MapHangfireDashboard();


app.UseHangfireDashboard("/test/gymfit", new DashboardOptions
{
    DashboardTitle = "Hangfire gymFit Application",
    DarkModeEnabled = true,
    DisplayStorageConnectionString = false

});

using var scope = app.Services.CreateScope();
var services = scope.ServiceProvider;

try
{
    var context = services.GetRequiredService<DatabaseContext>();

    await context.Database.MigrateAsync();

    await context.Database.EnsureCreatedAsync();

}
catch (Exception ex)
{
    var logger = services.GetRequiredService<ILogger<Program>>();
    logger.LogError(ex, "An error occurred during seed");
}

services.GetRequiredService<DatabaseContext>().Database.EnsureCreated();


string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "";
string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

var factory = new ConnectionFactory
{
    HostName = hostname,
    UserName = username,
    Password = password,
    VirtualHost = virtualHost,
};
 using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();


channel.QueueDeclare(queue: "notification",
                     durable: false,
                     exclusive: false,
                     autoDelete: true,   
                     arguments: null);

Console.WriteLine(" [*] Waiting for messages.");

var consumer = new EventingBasicConsumer(channel);
consumer.Received += async (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine(message.ToString());
    var notification = JsonSerializer.Deserialize<NotificationRabbitUpsertDto>(message);
    using (var scope = app.Services.CreateScope())
    {
        var notificationsService = scope.ServiceProvider.GetRequiredService<INotificationRabbitService>();

        if (notification != null)
        {
            try
            {

                await notificationsService.AddAsync(notification);
            }
            catch (Exception e)
            {

            }
        }
    }
    Console.WriteLine(Environment.GetEnvironmentVariable("Some"));
};
channel.BasicConsume(queue: "notification",
                     autoAck: true,
                     consumer: consumer);


app.UseHangfireDashboard();
app.MapHangfireDashboard();

app.Run();
