function reset(){
	var auth = firebase.auth();
var emailAddress = document.getElementById("user_email").value

auth.sendPasswordResetEmail(emailAddress).then(function() {
  // Email sent.
  window.alert('email sent')
}).catch(function(error) {
  // An error happened.
  window.alert('acc not found')
});

}


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
	var user = firebase.auth().currentUser;

if (user) {
	window.location.href = "./user.html"
} else {
  // No user is signed in.
}

}

function signup(){
	var userEmail=document.getElementById("create_user_email").value
	var userPass=document.getElementById("create_user_pass").value
	var name=document.getElementById("name").value

	firebase.auth().createUserWithEmailAndPassword(userEmail, userPass).catch(function(error) {
  // Handle Errors here.
  var errorCode = error.code;
  var errorMessage = error.message;
  window.alert(errorMessage)
  // ...
});


var user = firebase.auth().currentUser;
if (user != null) {
	user.updateProfile({
  displayName: name,
}).then(function() {
  // Update successful.
}).catch(function(error) {
  // An error happened.
});
}
login()
}

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
document.querySelector('.img__btn').addEventListener('click', function() {
  document.querySelector('.cont').classList.toggle('s--signup');
});