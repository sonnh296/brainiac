// index for teacher - get all courses by a teacher
$(document).ready(function () {
    GetAllCoursesOfTeacher();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}
function GetAllCoursesOfTeacher() {
    let teacherId = getParameter("teacherId");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/GetAllCourses" ,
        success: function (result) {
            //console.log(result);
            let biggest = "";
            for (let i = 0; i < result.length; i++) {
                const actionUrl = "http://localhost:5016/Teacher/SingleCourseDetails?courseId=" + result[i].courseId;
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

function ViewCourseDetails() {
    $("#btn-details").click(function () {
        var catesSeltected = getCategoryChecked();
        let teacherId = getParameter("teacherId");
        let course = GetCourseInfo();
        if (!course.title || !course.courseName || !course.price) {
            alert("Course infos are missing");
        }
        //console.log(catesSeltected);

        else {
            course.categories = catesSeltected;
            $.ajax({
                headers: {
                    'Accept': '*/*',
                    'Content-Type': 'application/json'
                },
                data: JSON.stringify(course),
                type: "POST",
                url: "http://localhost:5020/Teacher/course/add/" + teacherId,
                success: function (result) {
                    alert("Added successfully");
                    console.log(result);
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
}


    //$(document).ready(function () {
    //    $.ajax({
    //        url: 'http://localhost:5020/Teacher/course/2',
    //        type: 'GET',
    //        dataType: 'json',
    //        success: function (data) {
    //            displayCourses(data);
    //        },
    //        error: function (xhr, status, error) {
    //            console.error(xhr.responseText);
    //        }
    //    });

    //    function displayCourses(courses) {
    //        var courseListHtml = '';
    //        courses.forEach(function (course) {
    //            courseListHtml += '<h2>' + course.courseName + '</h2>';
    //            courseListHtml += '<ul>';
    //            course.categories.forEach(function (category) {
    //                courseListHtml += '<li>' + category.categoryName + '</li>';
    //            });
    //            courseListHtml += '</ul>';
    //        });

    //        $('#courseList').html(courseListHtml);
    //    }
    //});
