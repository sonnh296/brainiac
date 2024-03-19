// add a resouce in a course
$(document).ready(function () {
    GetCourseInfo();
    GetHighestOrdinalResource();
    AddResourceToCourse();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}

function AddResourceToCourse() {
    $("#btn-save").click(function () {
        var rs = GetResourceToAdd();
        if (!rs.content || !rs.description) {
            alert("Resource infos are missing");
            return;
        }
        console.log(rs);
        //$.ajax({
        //    headers: {
        //        'Accept': '*/*',
        //        'Content-Type': 'application/json'
        //    },
        //    type: "POST",
        //    data: JSON.stringify(resource),
        //    url: "",
        //    success: function (result) {
        //        console.log(result);
        //    },
        //    error: function (error) {
        //        console.log(error);
        //    }
        //});
    });
    
}

function GetCourseInfo() {
    let teacherid = 2;
    let courseid = getParameter("courseid");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/GetSingleCourse?teacherId=" + encodeURIComponent(teacherid) + "&courseId=" + courseid,
        success: function (result) {
            //console.log(result);
            $('title').text(result.courseName);
            $("#course-info").text(result.courseName + " - Add resource");
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function GetResourceToAdd() {
    let name = $("#name").val().trim();
    let content = $("#content").val().trim();
    let description = $("#description").val().trim();
    let type = $("#type").val();
    let isFree = $('input[name="isFree"]:checked').val();
    let courseid = $('#course-id').data('param');
    let status = 1;
    
    const resource = {
        content : content,
        description : description,
        name : name,
        isFree : false,
        type : type,
        courseId : courseid,
        isFree : isFree,
        status: status
    }

    return resource;
}

function GetHighestOrdinalResource() {
    let courseid = getParameter("courseid");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Resource/GetLargestOrdinal/" + courseid,
        success: function (result) {
            
        },
        error: function (error) {
            console.log(error);
        }
    });

}

