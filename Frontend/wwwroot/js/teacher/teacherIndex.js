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
        url: "http://localhost:5020/Teacher/course/" + teacherId,
        success: function (result) {
            console.log(result);
            let biggest = "";
            for (let i = 0; i < result.length; i++) {
                const a = `
                    <div class="course-item">
                        <div class="course-name">
                            <strong>${result.courseName}</strong>
                        </div>
                        <div class="category-list">
                            <div class="category-chip">
                                <p>${result.categories.categoryName}</p>
                            </div>
                        </div>
                        <div>
                            <p class="course-description">
                                ${result.title}
                            </p>
                        </div>
                        <div>
                            <p class="course-price">Price: ${result.price} vnd</p>
                        </div>
                    </div>`;
                biggest += a;
            }
            console.log(biggest);
            $(".course-list").html(biggest);
        },
        error: function (error) {
            console.log(error);
        }
    });
}


    $(document).ready(function () {
        $.ajax({
            url: 'http://localhost:5020/Teacher/course/2',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                displayCourses(data);
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
            }
        });

        function displayCourses(courses) {
            var courseListHtml = '';
            courses.forEach(function (course) {
                courseListHtml += '<h2>' + course.courseName + '</h2>';
                courseListHtml += '<ul>';
                course.categories.forEach(function (category) {
                    courseListHtml += '<li>' + category.categoryName + '</li>';
                });
                courseListHtml += '</ul>';
            });

            $('#courseList').html(courseListHtml);
        }
    });
