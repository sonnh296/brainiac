$(document).ready(function () {
    $.ajax({
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: `http://localhost:5020/WeatherForecast`,
        success: function (result) {
            var biggest = "";
            for (let i = 0; i < result.length; i++) {
                const a = `
                    <tr>
                        <th scope="row">
                            ${result[i].date}</a>
                        </th>
                        <td>${result[i].temperatureC}</td>
                        <td>${result[i].temperatureF}</td>
                        <td>${result[i].summary}</td>
                    </tr>`;
                biggest += a;
            }
            $(".display").html(biggest);
        },
        error: function () {
            console.log(this.url);
            console.log(this.statusCode);
        }
    });
});
