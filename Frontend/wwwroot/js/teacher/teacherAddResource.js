// add a resouce in a course
$(document).ready(function () {
    GetCourseInfo();
    //GetHighestOrdinalResource();
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
        var resource = GetResourceToAdd();
        if (!resource.name || !resource.content || !resource.description) {
            alert("Resource infos are missing");
            return;
        }
        if (resource.type === "Resource type") {
            alert("Resource type is not selected");
            return;
        }
        var courseId = getParameter("courseid");
        console.log(resource);
        $.ajax({
            headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json'
            },
            type: "POST",
            data: JSON.stringify(resource),
            url: "http://localhost:5020/Teacher/Resource/AddResource/" + courseId,
            success: function () {
                //console.log(result);
                alert("Added successfully");
                location.href = "/teacher/SingleCourseDetails?courseId=" + courseId;
            },
            error: function (jqXHR) {
                if (jqXHR.status === 400) {
                    if (jqXHR.responseText.includes("existed")) {
                        alert("The course name is duplicated");
                    }
                    else {
                        console.log("Error:", jqXHR.responseText);
                    }
                } else {
                    console.log("Unexpected Error:", jqXHR.responseText);
                }
            }
        });
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
    let isFree = $('input[name="isFree"]:checked').val() == "1" ? true : false;
    let status = 1;
    
    const resource = {
        content : content,
        description : description,
        name : name,
        isFree : isFree,
        type : type,
        status: status, 
        ordinalNumber : 1
    }

    return resource;
}

//function GetHighestOrdinalResource() {
//    let courseid = getParameter("courseid");
//    $.ajax({
//        headers: {
//            'Accept': '*/*',
//            'Content-Type': 'application/json'
//        },
//        type: "GET",
//        url: "http://localhost:5020/Resource/GetLargestOrdinal/" + courseid,
//        success: function (result) {
            
//        },
//        error: function (error) {
//            console.log(error);
//        }
//    });

//}

