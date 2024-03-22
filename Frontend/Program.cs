using Frontend.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddScoped<IVnPayService, VnPayServiceImpl>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment()) {
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();
app.MapFallback(context => {
	context.Response.Redirect("/");
	return Task.CompletedTask;
});
app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Login}");
app.MapControllerRoute(
    name: "home",
    pattern: "{controller=HomePage}/{action=Index}/{id?}");
app.Run();
