const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

const overlay2 = document.getElementById('popup1');
const forGotButton = document.getElementById('forGot');
const closeButton = document.getElementById('close');

closeButton.addEventListener('click', () => {
	overlay2.style.visibility="hidden";
	overlay2.style.opacity="0";
	container.style.visibility="visible";
	container.style.opacity="1";
});

forGotButton.addEventListener('click', () => {
	container.style.visibility="hidden";
	container.style.opacity="0";
	overlay2.style.visibility="visible";
	overlay2.style.opacity="1";
});

signUpButton.addEventListener('click', () => {
	container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
	container.classList.remove("right-panel-active");
});
