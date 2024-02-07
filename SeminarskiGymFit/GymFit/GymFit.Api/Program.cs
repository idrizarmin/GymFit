using GymFit.Api;
using GymFit.Api.Controllers;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Infrastructure;
using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Stripe;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews()
                .AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");

//StripeConfiguration.ApiKey = builder.Configuration["Stripe:SecretKey"];

builder.Services.AddMapper();
builder.Services.AddValidators();
builder.Services.AddApplication();
builder.Services.AddInfrastructure();
builder.Services.AddDatabase(connectionStringConfig);
builder.Services.AddAuthenticationAndAuthorization(jwtTokenConfig);
builder.Services.AddOther();
builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


builder.Services.AddHangfire((sp, config) => {
    var conString = sp.GetRequiredService<IConfiguration>().GetConnectionString("Main");
    config.SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseSqlServerStorage(conString);

});
builder.Services.AddHangfireServer();




//builder.Services.Configure<ApiBehaviorOptions>(options =>
//{
//    options.SuppressModelStateInvalidFilter = true;
//});
//builder.Services.AddCors(options =>
//{
//    options.AddPolicy("CorsPolicy",
//        builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
//});

//builder.Services.Configure<ApiBehaviorOptions>(options => options.SuppressModelStateInvalidFilter = true);




//if (builder.Environment.IsDevelopment())
//{
//    builder.Services.AddSwagger();
//}

var app = builder.Build();




//if (app.Environment.IsDevelopment())
//{
//    app.UseSwagger();
//    app.UseSwaggerUI();
//}

app.UseSwagger();
app.UseSwaggerUI();

//app.UseCors("CorsPolicy");

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
//app.UseHangfireDashboard("/test/gymfit", new DashboardOptions
//{
//    DashboardTitle = "Hangfire gymFit Application",
//    DarkModeEnabled = true,
//    DisplayStorageConnectionString = false

//});

using var scope = app.Services.CreateScope();
var services = scope.ServiceProvider;

try
{
    var context = services.GetRequiredService<DatabaseContext>();

    await context.Database.MigrateAsync();

}
catch (Exception ex)
{
    var logger = services.GetRequiredService<ILogger<Program>>();
    logger.LogError(ex, "An error occurred during seed");
}


app.Run();
