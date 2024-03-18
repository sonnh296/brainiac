// add a resouce in a course
$(document).ready(function () {
    GetCourseInfo();
    AddResourceToCourse();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}

//function AddResourceToCourse() {
//    $("#btn-save").click(function () {
//        console.log("btn clicked");
//        let name = $("#name").val();
//        let content = $("#content").val();
//        let description = $("#description").val();
//        let type = $("#type").val();
//        //let isFree = $("#").val();
//        let courseid = $('#course-id').data('param');
//        //console.log("name: " + name);

//        //const resource = {
//        //    content = content,
//        //    description = description,
//        //    name = name,
//        //    isFree = false,
//        //    type = type,
//        //    courseId = courseid
//        //};
//        $.ajax({
//            headers: {
//                'Accept': '*/*',
//                'Content-Type': 'application/json'
//            },
//            type: "POST",
//            data: JSON.stringify(resource),
//            url: "",
//            success: function (result) {
//                console.log(result);
//            },
//            error: function (error) {
//                console.log(error);
//            }
//        });
//    });
    
//}

function GetCourseInfo() {
    $("#course-id").text("Course XYZ");

    //$.ajax({
    //    headers: {
    //        'Accept': '*/*',
    //        'Content-Type': 'application/json'
    //    },
    //    type: "GET",
    //    url: "",
    //    success: function (result) {
    //        //$("#set-cate").html(result.courseName);
    //        $("#course-id").val("Course XYZ");
    //    },
    //    error: function (error) {
    //        console.log(error);
    //    }
    //});
}
