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
    let courseId = getParameter("courseId");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        //url: "http://localhost:5020/Teacher/GetSingleCourse/" + courseId,
        url: "https://jsonplaceholder.typicode.com/posts/1",
        success: function (result) {
            debugger;
            var title = "";
            console.log(result);
            for (let i = 0; i < result.length; i++){
                title = result[i].title;
                //$('#course-description').val(r.body);
                //$('#course-author').val(r.userId);
                //$('#course-price').val(r.id);
            }
            console.log(title);
            $('#course-title-name').val(title);
            //$('#course-description').val(result.title);
            //$('#course-author').val(result.userId);
            //$('#course-price').val(result.id);
        },
        error: function (error) {
            console.log(error);
        }
    });
}


