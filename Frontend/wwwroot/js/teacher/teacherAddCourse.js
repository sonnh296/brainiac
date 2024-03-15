// teacher save draft new course
$(document).ready(function () {
    SaveDraftCourse();
    PublishCourse();
    GetCategories();
    
});

function SaveDraftCourse() {
    $("#btn-save-draft").click(function () {
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

function PublishCourse() {
    $("#btn-publish").click(function () {
        console.log("Publish clicked");
        const course = GetCourseInfo();

        if (!course.title || !course.courseName || !course.price) {
            alert("Course infos are missing");
        }
        //else {
        //    alert("name:" + name);
        //    let course = {
        //        name: name,
        //        title: title,
        //        price: price,
        //        status: "draft"
        //    };
        //    $.ajax({
        //        headers: {
        //            'Accept': '*/*',
        //            'Content-Type': 'application/json'
        //        },
        //        data: JSON.stringify(course),
        //        type: "POST",
        //        url: "http://localhost:5020/Teacher/course/add/2",
        //        success: function () {
        //            alert("Added successfully");
        //        },
        //        error: function (error) {
        //            console.log(error);
        //        }
        //    });
        //}
    });
}

function GetCourseInfo() {
    let title = $("#courseTitle").val();
    let name = $("#courseName").val();
    let price = $("#coursePrice").val();

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
            //console.log(biggest);
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