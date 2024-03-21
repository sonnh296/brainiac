// get a single course details of a teacher by course id
$(document).ready(function () {
    GetCourseDetails();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}
function GetCourseDetails() {
    let teacherId = 2;
    let courseId = getParameter("courseId");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/GetSingleCourse?teacherId=" + teacherId + "&courseId=" + courseId,
        success: function (result) {
            //console.log(result);
            let biggest = "";
            for (let i = 0; i < result.categories.length; i++) {
                const a = `
                    <div class="category-chip">
                        <p>${result.categories[i].categoryName}</p>
                    </div>`;
                biggest += a;
            }
            $('.category-list').html(biggest);
            $('#course-title-name').val(result.courseName);
            $('#course-description').val(result.title);
            $('#price').val(result.price + " vnd");
        },
        error: function (error) {
            console.log(error);
        }
    });
}


