
// get a single course details of a teacher by course id
$(document).ready(function () {
    GetCourseDetails();
    getCourseLessons();
    saveChanges();
    deleteCourse();
    redirect();
});

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}
function GetCourseDetails() {
    let teacherId = getUserId();
    let courseId = getParameter("courseId");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/course/single/" + teacherId + "/" + courseId,
        success: function (result) {
            //console.log(result);
            let biggest = "";
            for (let i = 0; i < result.categories.length; i++) {
                const a = `
                    <div class="category-chip">
                        <p>${result.categories[i].categoryName}</p>
                    </div>`;
                biggest += a;
            }
            $('.category-list').html(biggest);
            $('#course-title-name').val(result.courseName);
            $('#course-description').val(result.title);
            $('#price').val(result.price);
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function saveChanges() {
    $("#save-button").click(function () {
        let teacherId = getUserId();
        let courseId = getParameter("courseId");
        let name = $("#course-title-name").val();
        let description = $("#course-description").val();
        let price = $("#price").val();
        if (!name || !description || !price) {
            alert("Course info cannot be empty");
            return;
        }
        const course = {
            courseName: name,
            title: description,
            price: price
        };
        $.ajax({
            headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json'
            },
            type: "PUT",
            data: JSON.stringify(course),
            url: "http://localhost:5020/Teacher/course/edit/" + teacherId + "/" + courseId,
            success: function (result) {
                console.log(result);
                saveButton.disabled = true;
                editButton.textContent = "Edit";
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
}
function redirect() {
    $('#btn-add').click(function () {
        let courseId = getParameter("courseId");
        var baseUrl = $(this).data('url');
        var url = baseUrl + '?courseId=' + courseId;
        window.location.href = url;
    });
}
function deleteCourse() {
    $("#btn-delete").click(function () {
        let teacherId = getUserId();
        let courseId = getParameter("courseId");
        $.ajax({
            headers: {
                'Accept': '*/*',
                'Content-Type': 'application/json'
            },
            type: "PUT",
            url: "http://localhost:5020/course/delete/" + teacherId + "/" + courseId,
            success: function (result) {
                console.log(result);
                alert("Deleted successfully");
                location.href = '/teacher';
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
}

function getCourseLessons() {
    let courseId = getParameter("courseId");
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Teacher/course/resource/list/" + courseId,
        success: function (result) {
            //console.log(result);
            let biggest = "";
            for (let i = 0; i < result.length; i++) {
                const a = `
                    <div class="single-lesson">
                        <button class="accordion">${result[i].name}</button>
                        <div class="panel">
                            <p>${result[i].description}</p>
                            <div class="edit-lesson">
                                <button>Edit</button>
                            </div>
                        </div>
                    </div>`;
                biggest += a;
            }
            $('.lessons').html(biggest);
            var acc = document.getElementsByClassName("accordion");
            for (var i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var panel = this.nextElementSibling;
                    if (panel.style.display === "block") {
                        panel.style.display = "none";
                    } else {
                        panel.style.display = "block";
                    }
                });
            }
        },
        error: function (error) {
            console.log(error);
        }
    });
}


