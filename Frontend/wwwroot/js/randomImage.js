function getRandomStringFromArray() {
    const myStringArray = [
        "apple",
        "banana",
        "orange",
        "grape",
        "apple",
        "banana",
        "orange",
        "grape",
        "apple",
        "banana",
        "orange",
        "grape",
        "apple",
        "banana",
        "orange",
        "grape",
        "apple",
        "banana",
        "orange",
        "grape",
        "apple",
        "banana",
        "orange",
        "grape",
        "kiwi"];
  
    // Generate a random index within the range of the array length
    const randomIndex = Math.floor(Math.random() * stringArray.length);

    // Return the string at the random index
    return stringArray[randomIndex];
}

// Example usage:
