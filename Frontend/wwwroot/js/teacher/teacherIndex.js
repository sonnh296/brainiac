// index for teacher - get all courses by a teacher
$(document).ready(function () {
    GetAllCoursesOfTeacher();
    searchCourse();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
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
function GetAllCoursesOfTeacher() {
    const tk = getAccessToken()
    let teacherId = getUserId();
    console.log(teacherId);
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + tk
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/GetAllCourses/" + teacherId,
        success: function (result) {
            //console.log(result);
            let biggest = "";
            for (let i = 0; i < result.length; i++) {
                var statusText = getCourseStatus(result[i].status);
                const actionUrl = "http://localhost:5016/teacher/singleCourseDetails?courseId=" + result[i].courseId;
                const a = `
                    <div class="course-item">
                        <div class="course-name">
                            <strong>${result[i].courseName}</strong>
                        </div>
                        <div class="course-description">
                            <p>${result[i].title}</p>
                        </div>
                        <div class="course-price">
                            <p>Price: ${result[i].price} vnd</p>
                        </div>
                        <div class="view-details">
                            <a href="${actionUrl}" class="btn btn-primary">View details</a>
                        </div>
                        <div class="course-status">
                            <p>${statusText}</p>
                        </div>
                    </div>`;
                biggest += a;
            }
            $(".course-list").html(biggest);
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function getCourseStatus(statusId) {
    switch (statusId) {
        case "1":
            return "Draft";
        case "2":
            return "Pending";
        case "3":
            return "Published";
        default:
            return "Deleted";
    }
}

function searchCourse() {
    $("#btn-search").click(function (e) {
        e.preventDefault();
        let teacherId = getUserId();
        var searchword = $("#txt-search").val();
        if (!searchword) {
            return;
        }
        $.ajax({
            headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json'
            },
            type: "GET",
            url: "http://localhost:5020/Teacher/course/search/" + teacherId + "/" + searchword,
            success: function (result) {
                //console.log(result);
                let biggest = "";
                for (let i = 0; i < result.length; i++) {
                    var statusText = getCourseStatus(result[i].status);
                    const actionUrl = "http://localhost:5016/teacher/singleCourseDetails?courseId=" + result[i].courseId;
                    const a = `
                    <div class="course-item">
                        <div class="course-name">
                            <strong>${result[i].courseName}</strong>
                        </div>
                        <div class="course-description">
                            <p>${result[i].title}</p>
                        </div>
                        <div class="course-price">
                            <p>Price: ${result[i].price} vnd</p>
                        </div>
                        <div class="view-details">
                            <a href="${actionUrl}" class="btn btn-primary">View details</a>
                        </div>
                        <div class="course-status">
                            <p>${statusText}</p>
                        </div>
                    </div>`;
                    biggest += a;
                }
                $(".course-list").html(biggest);
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
}
