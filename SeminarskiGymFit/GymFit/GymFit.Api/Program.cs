using GymFit.Api;
using GymFit.Api.Controllers;
using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Infrastructure;
using Hangfire;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");

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
builder.Services.AddHangfire( (sp, config) => {
    var conString = sp.GetRequiredService<IConfiguration>().GetConnectionString("Main");
    config.SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UseSqlServerStorage(conString);

});
builder.Services.AddHangfireServer();




builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});
builder.Services.AddCors(options => options.AddPolicy(
    name: "CorsPolicy",
    builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()
));

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
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.UseHangfireDashboard("/test/gymfit", new DashboardOptions
{
    DashboardTitle = "Hangfire gymFit Application",
    DarkModeEnabled = true,
    DisplayStorageConnectionString = false

});


app.Run();


