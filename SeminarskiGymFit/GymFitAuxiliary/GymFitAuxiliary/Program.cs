using GymFitAuxiliary.Config;
using GymFitAuxiliary;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");

builder.Services.AddAuthenticationAndAuthorization(jwtTokenConfig);

builder.Services.AddResponseCaching();


builder.Services.AddControllers();




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

// Configure the HTTP request pipeline.
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

app.Run();
