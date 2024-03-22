function getRandomStringFromArray() {
    const stringArray = [
        "./img/randomimage/2 (1).jpg",
        "./img/randomimage/2 (2).jpg",
        "./img/randomimage/2 (4).jpg",
        "./img/randomimage/2 (7).jpg",
        "./img/randomimage/2 (8).jpg",

        "./img/randomimage/2 (2).png",
        "./img/randomimage/2 (4).png",
        "./img/randomimage/2 (5).png",
        "./img/randomimage/2 (6).png",
        "./img/randomimage/2 (7).png",
        "./img/randomimage/2 (9).png",
        "./img/randomimage/2 (10).png",
        "./img/randomimage/2 (8).png"];
  
    // Generate a random index within the range of the array length
    const randomIndex = Math.floor(Math.random() * stringArray.length);

    // Return the string at the random index
    return stringArray[randomIndex];
}
function getRandomStringFromArrayforSearch() {
    const stringArray = [
        "/imgs/randomimage/2 (1).jpg",
        "/imgs/randomimage/2 (2).jpg",
        "/imgs/randomimage/2 (4).jpg",
        "/imgs/randomimage/2 (7).jpg",
        "/imgs/randomimage/2 (8).jpg",

        "/imgs/randomimage/3 (2).png",
        "/imgs/randomimage/3 (4).png",
        "/imgs/randomimage/3 (5).png",
        "/imgs/randomimage/3 (6).png",
        "/imgs/randomimage/3 (7).png",
        "/imgs/randomimage/3 (9).png",
        "/imgs/randomimage/3 (10).png",
        "/imgs/randomimage/3 (8).png"];

    // Generate a random index within the range of the array length
    const randomIndex = Math.floor(Math.random() * stringArray.length);
    // Return the string at the random index
    return stringArray[randomIndex];
}
// Example usage:
