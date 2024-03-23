// add a resouce in a course
$(document).ready(function () {
    GetCourseInfo();
    AddResourceToCourse();
});

function getAccessTokenAdd() {

    if (getUserId() == null || getUserId() == undefined) {
        document.cookie = `web-at=;max-age=0; path=/`;
        document.cookie = `web-rt=; max-age=0;path=/`;
        document.cookie = `user-id=; max-age=0;path=/`;
        window.location.href = "/";
    }
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            return cookie.substring(7);
        }
    }
    var rt = getRefreshToken();
    if (rt != null && rt != undefined) {
        fetch("http://localhost:5020/api/refresh_token", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",

            },
            body: JSON.stringify({
                userId: parseInt(getUserId()),
                refreshToken: rt,
            })
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.accessToken != null && data.accessToken != undefined) {
                    document.cookie = `web-at=${data.accessToken};max-age=900; path=/`;
                    document.cookie = `web-rt=${data.refreshtoken}; max-age=864000;path=/`;
                    getAccessToken()
                } else {
                    window.location.href = "/";
                }
            }).catch(e => {
                window.location.href = "/";
            });
    } else {
        window.location.href = "/";
    }

    return null;
}

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
        var courseId = getParameter("courseId");
        console.log(resource);
        $.ajax({
            headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json'
            },
            type: "POST",
            data: JSON.stringify(resource),
            url: "http://localhost:5020/Teacher/resource/add/" + courseId,
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
function getAccessTokenTea() {

    if (getUserId() == null || getUserId() == undefined) {
        document.cookie = `web-at=;max-age=0; path=/`;
        document.cookie = `web-rt=; max-age=0;path=/`;
        document.cookie = `user-id=; max-age=0;path=/`;
        window.location.href = "/";
    }
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith("web-at=")) {
            return cookie.substring(7);
        }
    }
    var rt = getRefreshToken();
    if (rt != null && rt != undefined) {
        fetch("http://localhost:5020/api/refresh_token", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
            },
            body: JSON.stringify({
                userId: parseInt(getUserId()),
                refreshToken: rt,
            })
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.accessToken != null && data.accessToken != undefined) {
                    document.cookie = `web-at=${data.accessToken};max-age=900; path=/`;
                    document.cookie = `web-rt=${data.refreshtoken}; max-age=864000;path=/`;
                    getAccessToken()
                } else {
                    window.location.href = "/";
                }
            }).catch(e => {
                window.location.href = "/";
            });
    } else {
        window.location.href = "/";
    }

    return null;
}
function GetCourseInfo() {
    const tk = getAccessTokenTea();
    let teacherid = getUserId();
    let courseid = getParameter("courseid");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        
        url: "http://localhost:5020/Teacher/course/single/" + teacherid + "/" + courseid,
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
        status: status
    }

    return resource;
}

