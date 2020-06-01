//Function to check for authentication state change
firebase.auth().onAuthStateChanged(function(user) {
	window.user = user;
	if(user){
		window.location.href="./user.html"
	}
});

//Function to send passwoerd reset email
function reset(){
	var auth = firebase.auth();
	var emailAddress = document.getElementById("user_email").value
	auth.sendPasswordResetEmail(emailAddress).then(function() {
	// Email sent.
	document.getElementById("sigining").style.display = 'none';
	document.getElementById("p_em").innerHTML= 'if the email provided is correct an email with password reset link will be sent to you.';
}).catch(function(error) {
	// An error happened.
});
}

//Function For logging in user
function login(){
	var userEmail=document.getElementById("user_email").value
	var userPass=document.getElementById("user_pass").value
	firebase.auth().signInWithEmailAndPassword(userEmail, userPass).catch(function(error) {
		// Handle Errors here.
		var errorCode = error.code;
		var errorMessage = error.message;
		window.alert(errorMessage)
		// ...	
});
}

//Function For Signing Up
function signup(){
	var userEmail=document.getElementById("create_user_email").value
	var userPass=document.getElementById("create_user_pass").value
	var name=document.getElementById("name").value

	//Function For Creating User Id
	firebase.auth().createUserWithEmailAndPassword(userEmail, userPass).catch(function(error) {
	// Handle Errors here.
	var errorCode = error.code;
	var errorMessage = error.message;
	// ...
});

	//Function to check for authentication state change
	firebase.auth().onAuthStateChanged(function(user) {
		window.user = user;
		if(user){
			var user = firebase.auth().currentUser;
			user.updateProfile({
				displayName: name,
			}).then(function() {
			// Update successful.
			}).catch(function(error){
			// An error happened.
		});
		}
	});
}

//Function For Google Sign in
function withGoogle(){
	var provider = new firebase.auth.GoogleAuthProvider();
	firebase.auth().signInWithPopup(provider).then(function(result) {
		// This gives you a Google Access Token. You can use it to access the Google API.
		var token = result.credential.accessToken;
		// The signed-in user info.
		var user = result.user;
		window.location.href = "./user.html"
		// ...
	}).catch(function(error) {
		// Handle Errors here.
		var errorCode = error.code;
		var errorMessage = error.message;
		// The email of the user's account used.
		var email = error.email;
		// The firebase.auth.AuthCredential type that was used.
		var credential = error.credential;
		// ...
	});
}

//Code For Login Animation
document.querySelector('.img__btn').addEventListener('click',
	function() {
		document.querySelector('.cont').classList.toggle('s--signup');
	});