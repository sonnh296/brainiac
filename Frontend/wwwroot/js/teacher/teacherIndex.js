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
            var count = 0;
            var a = "";
            for (let i = 0; i < result.length; i++) {
                var statusText = getCourseStatus(result[i].status);
                const actionUrl = "http://localhost:5016/teacher/singleCourseDetails?courseId=" + result[i].courseId;
                if (count == 0) {
                     a = `
                     <a href="${actionUrl}" class="course" style="text-decoration: none;">
                    <li style="height: 280px;width: 200px;--accent-color:#0D6EFD">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                }
                if (count == 1) {
                     a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                     <li style="    height: 280px;width: 200px;--accent-color: #6710F5;">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                }
                if (count == 2) {
                     a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                   <li style="  height: 280px;width: 200px;--accent-color:#6F42C1">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                }
                if (count ==3) {
                     a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                       <li style=" height: 280px;width: 200px;--accent-color:#D63384">

                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                }
                if (count == 4) {
                     a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                    <li style=" height: 280px;width: 200px;--accent-color:#DC3545">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                }
               
                count++;
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
                var count = 0;
                var a = "";
                for (let i = 0; i < result.length; i++) {
                    var statusText = getCourseStatus(result[i].status);
                    const actionUrl = "http://localhost:5016/teacher/singleCourseDetails?courseId=" + result[i].courseId;
                    if (count == 0) {
                        a = `
                     <a href="${actionUrl}" class="course" style="text-decoration: none;">
                    <li style="height: 280px;width: 200px;--accent-color:#0D6EFD">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                    }
                    if (count == 1) {
                        a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                     <li style="    height: 280px;width: 200px;--accent-color: #6710F5;">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                    }
                    if (count == 2) {
                        a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                   <li style="  height: 280px;width: 200px;--accent-color:#6F42C1">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                    }
                    if (count == 3) {
                        a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                       <li style=" height: 280px;width: 200px;--accent-color:#D63384">

                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                    }
                    if (count == 4) {
                        a = `
                     <a href="${actionUrl}" class="course"  style="text-decoration: none;">
                    <li style=" height: 280px;width: 200px;--accent-color:#DC3545">
                        <div class="icon"><i class="fa-brands fa-codepen"></i></div>
                        <div class="title">${result[i].courseName}</div>
      
                        <div class="descr">${result[i].title}
                          <div style ="margin-left: 30%;     margin-top: 48%;">
                      <div class="price">Price:  ${result[i].price} VND  </div>
                      <div class="status">Status: ${statusText}</div>
                      </div>
                      </div>
     
      
                    </li>
                      </a>

                    `;
                    }

                    count++;
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
