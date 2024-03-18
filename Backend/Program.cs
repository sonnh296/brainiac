using AutoMapper;
using Backend.Configurations;
using Backend.Models;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Backend.App.Extensions;
using Backend.Auth.Helpers;
using Backend.Auth.Interfaces;
using Backend.Auth.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddCors();
builder.Services.AddControllers();
builder.Services.AddDbContext<PRN231_V2Context>();
builder.Services.AddAppServices();


builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = TokenHelper.Issuer,
            ValidAudience = TokenHelper.Audience,
            IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(TokenHelper.Secret))
        };

    });
builder.Services.AddTransient<ITokenService, TokenService>();
builder.Services.AddTransient<Backend.Auth.Interfaces.IUserService, UserService>();
builder.Services.AddSwaggerGen(opt =>
{
    var securitySchema = new OpenApiSecurityScheme
    {
        Name = "Authorization",
        BearerFormat = "JWT",
        Description = "JWT Authorization header using the Bearer scheme.",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        In = ParameterLocation.Header,
        Reference = new OpenApiReference
        {
            Type = ReferenceType.SecurityScheme,
            Id = "Bearer"
        }
    };
    opt.AddSecurityDefinition("Bearer", securitySchema);
    var securityRequirement = new OpenApiSecurityRequirement
    {
        { securitySchema, new[] { "Bearer" } }
    };
});


builder.Services.AddAuthorization();

var mapperConfig = new MapperConfiguration(mc =>
{
    mc.AddProfile(new AutoMapperProfile());
});

IMapper mapper = mapperConfig.CreateMapper();
builder.Services.AddSingleton(mapper);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();
app.UseCors(builder => {
    builder.WithOrigins("*")
                            .AllowAnyHeader()
                            .AllowAnyMethod();
});

app.Run();
