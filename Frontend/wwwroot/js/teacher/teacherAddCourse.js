// teacher save draft new course
$(document).ready(function () {
    $("#send").on('click', '#btn-save-draft', function () {
        let title = $("#courseTitle").val();
        let name = $("#courseName").val();
        let price = $("#coursePrice").val();

        if (!title || !name || !price) {
            alert("Course infos are missing");
        } else {
            alert("name:" + name);
            let course = {
                name: name,
                title: title,
                price: price,
                status: "draft"
            };
            $.ajax({
                headers: {
                    'Accept': '*/*',
                    'Content-Type': 'application/json'
                },
                data: JSON.stringify(course),
                type: "POST",
                url: "http://localhost:5020/Teacher/course/add/2",
                success: function () {
                    alert("Added successfully");
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }
    });
});