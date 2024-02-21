const inputField = document.getElementById("course-title-name");
const course_description = document.getElementById("course-description");
const author_name = document.getElementById("author-name");
const price = document.getElementById("price");
const editButton = document.getElementById("edit-button");
const saveButton = document.getElementById("save-button");

editButton.addEventListener("click", () => {
    changeAllInputs(!inputField.disabled);
    editButton.textContent = inputField.disabled ? "edit info" : "Cancel";

    saveButton.disabled = inputField.disabled;
});

saveButton.addEventListener("click", () => {
    changeAllInputs(!inputField.disabled);
    alert("Your changes have been saved");

    saveButton.disabled = true;
    editButton.textContent = "edit info";
});

const changeAllInputs = (disabled) => {
    inputField.disabled = disabled;
    course_description.disabled = disabled;
    author_name.disabled = disabled;
    price.disabled = disabled;
    inputField.style.backgroundColor = disabled ? "#f0f0f0" : "#fff";
    course_description.style.backgroundColor = disabled ? "#f0f0f0" : "#fff";
    author_name.style.backgroundColor = disabled ? "#f0f0f0" : "#fff";
    price.style.backgroundColor = disabled ? "#f0f0f0" : "#fff";
};
