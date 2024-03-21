// teacher save draft new course
$(document).ready(function () {
    GetCategories();
    SaveDraftCourse();
});

function SaveDraftCourse() {
    $("#btn-save-draft").click(function () {
        const id = getUserId()
        var catesSeltected = getCategoryChecked();
        const teacherId = 16;
        let course = GetCourseInfo();

        if (!course.title || !course.courseName || !course.price || catesSeltected.length < 1) {
            alert("Course infos are missing");
        }

        else {
            course.categories = catesSeltected;
            $.ajax({
                headers: {
                    'Accept': '*/*',
                    'Content-Type': 'application/json'
                },
                data: JSON.stringify(course),
                type: "POST",
                url: "http://localhost:5020/Teacher/addCourse/" + teacherId,
                success: function () {
                    alert("Added successfully");
                    location.href = "/teacher";
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 400) {
                        if (jqXHR.responseText.includes("existed")) {
                            alert("The course name is duplicated");
                        }
                        else {
                            console.log("Unknown Bad Request occurred");
                        }
                    } else {
                        console.log("Unexpected Error:", jqXHR.responseText);
                    }
                }
            });
        }
    });
}

function GetCourseInfo() {
    let title = $("#courseTitle").val().trim();
    let name = $("#courseName").val().trim();
    let price = $("#coursePrice").val().trim();

    const course = {
        title: title,
        courseName: name,
        price: price
    }

    return course;
}

function GetCategories() {
    
    $.ajax({
        headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
        },
        type: "GET",
        url: "http://localhost:5020/Category/getAll",
        success: function (result) {
            let biggest = "";
            for (let i = 0; i < result.length; i++) {
                const a = `
                    <label for="${result[i].categoryId}">
                        <input type="checkbox" id="${result[i].categoryId}" name="categories[]" value="${result[i].categoryId}">
                        ${result[i].categoryName}
                    </label>`;
                biggest += a;
            }
            $("#set-cate").html(biggest);
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function getParameter(param) {
    var urlVar = window.location.search.substring(1);
    var urlParam = urlVar.split('=');
    if (urlParam[0] == param) {
        return urlParam[1];
    }
}

function getCategoryChecked() {
    var selectedCategories = [];
    var selected = {};
    var cateCheckbox = document.querySelectorAll('input[name="categories[]"]');
    cateCheckbox.forEach((checkbox) => {
        if (checkbox.checked) {
            selected = {
                categoryId: checkbox.getAttribute("value"),
                categoryName: checkbox.parentElement.textContent.trim()
            };
            selectedCategories.push(selected);
        }
    });
    //console.log(selectedCategories);
    return selectedCategories;
}