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
            for (let i = 0; i < result.resources.length; i++) {
                const a = `
                    <div class="single-lesson">
                    <button class="accordion">Lesson ${i+1}</button>
                    <div class="panel">
                        <p>${result.resources[i].description}</p>
                        <div class="edit-lesson">
                            <button>Edit</button>
                        </div>
                    </div>
                </div>`;
                biggest += a;
            }
            $('#course-title-name').val(result.courseName);
            $('#course-description').val(result.title);
            $('#price').val(result.price + " vnd");
            $('.lessons').html(biggest);
        },
        error: function (error) {
            console.log(this.url);
            console.log(error);
        }
    });
}


