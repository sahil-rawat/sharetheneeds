// ---------Responsive-navbar-active-animation-----------
function test(){
	var tabsNewAnim = $('#navbarSupportedContent');
	var selectorNewAnim = $('#navbarSupportedContent').find('li').length;
	var activeItemNewAnim = tabsNewAnim.find('.active');
	var activeWidthNewAnimHeight = activeItemNewAnim.innerHeight();
	var activeWidthNewAnimWidth = activeItemNewAnim.innerWidth();
	var itemPosNewAnimTop = activeItemNewAnim.position();
	var itemPosNewAnimLeft = activeItemNewAnim.position();
	$(".hori-selector").css({
		"top":itemPosNewAnimTop.top + "px", 
		"left":itemPosNewAnimLeft.left + "px",
		"height": activeWidthNewAnimHeight + "px",
		"width": activeWidthNewAnimWidth + "px"
	});
	$("#navbarSupportedContent").on("click","li",function(e){
		$('#navbarSupportedContent ul li').removeClass("active");
		$(this).addClass('active');
		var activeWidthNewAnimHeight = $(this).innerHeight();
		var activeWidthNewAnimWidth = $(this).innerWidth();
		var itemPosNewAnimTop = $(this).position();
		var itemPosNewAnimLeft = $(this).position();
		$(".hori-selector").css({
			"top":itemPosNewAnimTop.top + "px", 
			"left":itemPosNewAnimLeft.left + "px",
			"height": activeWidthNewAnimHeight + "px",
			"width": activeWidthNewAnimWidth + "px"
		});
	});
}
$(document).ready(function(){
	setTimeout(function(){ test(); });
});
$(window).on('resize', function(){
	setTimeout(function(){ test(); }, 500);
});
$(".navbar-toggler").click(function(){
	setTimeout(function(){ test(); });
});


//Function For Signing Out User
function signOut(){
	firebase.auth().signOut().then(function() {
		// Sign-out successful.
		window.location.href="./index.html"
	}).catch(function(error) {
		// An error happened.
	});
}


//Function For Switching to Dashboard Tab
function dashb(){
	document.getElementById("Dashboard").style.display="block";
	document.getElementById("AddMarker").style.display="none";
	document.getElementById("Profile").style.display="none";
	document.getElementById("ViewMarker").style.display="none";
}


//Function For Switching to Add Marker Tab
function am(){
	document.getElementById('autocomplete').value=""
	document.getElementById("Dashboard").style.display="none";
	document.getElementById("AddMarker").style.display="block";
	document.getElementById("Profile").style.display="none";
	document.getElementById("ViewMarker").style.display="none";
}


//Function For Switching to View Marker Tab
function vm(){
	document.getElementById("Dashboard").style.display="none";
	document.getElementById("AddMarker").style.display="none";
	document.getElementById("Profile").style.display="none";
	document.getElementById("ViewMarker").style.display="block";
}


//Function For Switching to Profile Tab
function pf(){
	document.getElementById("Dashboard").style.display="none";
	document.getElementById("AddMarker").style.display="none";
	document.getElementById("Profile").style.display="block";
	document.getElementById("ViewMarker").style.display="none";
	firebase.auth().onAuthStateChanged(function(user) {
		if (user) {
			// User is signed in.
			var user = firebase.auth().currentUser;
			user.providerData.forEach(function (profile) {
				var photo=profile.photoURL
				var name=profile.displayName
				var email=profile.email
				if(photo!=null){
					document.getElementById("p_image").src=photo
				}
				document.getElementById("p_name").innerHTML=name
				document.getElementById("p_email").innerHTML=email
			});
		}else {
		// No user is signed in.
		window.location.href="./login.html";
		}
	});
}


//Showing Map On Dashboard Tab
var placeSearch,autocomplete,map;
function myMap() {
	var mapProp= {
		center:new google.maps.LatLng(25.2744,133.7751),
			zoom:10,
			};
	map = new google.maps.Map(
		document.getElementById("googleMap")
		,mapProp
		);

	//var searchBox = new google.maps.places.SearchBox(document.getElementById('autocomplete'));
		autocomplete = new google.maps.places.Autocomplete(
		document.getElementById('autocomplete'));
		google.maps.event.addListener(autocomplete,'place_changed', fillInAddress);

		
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
			var loc = {
			lat: position.coords.latitude,
			lng: position.coords.longitude
			};
			map.setCenter(loc);
		});
	}
function addMarker(loc,cont){
	var contentString = `<div id="content">`+
	`<div id="siteNotice">`+
	`</div>`+
	`<h1 id="firstHeading" class="firstHeading">${cont['type']}</h1>`+
	`<div id="bodyContent">`+
	`<p>Provided by ${cont['name']}</p>`+
	`<p>Email id:- ${cont['email']}</p>`+
	`<p>Phone No.- ${cont['phone']}</p>`+
	`<p>${cont['street']}`+
	`<p>${cont['description']}</p>`+
	`</div>`+
	`</div>`;
	var infowindow = new google.maps.InfoWindow({
		content: contentString
		})
	var marker = new google.maps.Marker({
				position: loc,
				map: map,
				title: cont['type'],
			});
			marker.addListener('click', function() {
				map.setZoom(17)
				map.setCenter(loc)
				infowindow.open(map, marker);
				});
	}
	
	var db=firebase.firestore();
		db.collection("markers").get().then((querySnapshot) => {
			querySnapshot.forEach((doc) => {
				var dd={};
				var loc_lat,loc_lng;
				dd['type']=doc.data()['type']
				dd['name']=doc.data()['name']
				dd['mail']=doc.data()['email']
				dd['phone']=doc.data()['phone']
				dd['street']=doc.data()['street']
				dd['Description']=doc.data()['Description']
				loc_lat=doc.data()['latitude']
				loc_lng=doc.data()['longitude']
				addMarker(new google.maps.LatLng(loc_lat, loc_lng),dd)
			});
		});	
		function geolocate() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
			var geolocation = {
			lat: position.coords.latitude,
			lng: position.coords.longitude
			};
			var circle = new google.maps.Circle({
				center: geolocation,
				radius: position.coords.accuracy
			});
			autocomplete.setBounds(
			circle.getBounds()
			);
			});
		}
	}
}
var lat,lng;
function fillInAddress() {
	var address=autocomplete.getPlace()
	lat=address.geometry.location.lat()
	lng=address.geometry.location.lng()
}

function collectData(){
	console.log(lat,lng)
	var data={};
	var ele = document.getElementsByName('type'); 
	for(i = 0; i < ele.length; i++) { 
		if(ele[i].checked){ 
								data['type']= ele[i].value; 
						} 
				}
	data['lat']=lat
	data['lng']=lng
	data['name']=document.getElementById('name').value
	data['mail']=document.getElementById('mail').value
	data['phone']=document.getElementById('phone').value
	data['streetAddress']=document.getElementById('adressInput').value
	data['Description']=document.getElementById('bio').value
	var db = firebase.firestore();
	// Add a second document with a generated ID.
	db.collection("markers").add({
	'latitude':data['lat'],
	'longitude':data['lng'],
	'type':data['type'],
	'name':data['name'],
	'email':data['mail'],
	'phone':data['phone'],
	'street':data['streetAddress'],
	'Description':data['Description']
})
.then(function(docRef) {
	console.log("Document written with ID: ", docRef.id);
	window.alert('Marker Added')
	document.getElementById('food').checked=false
	document.getElementById('grocery').checked=false
	document.getElementById('sanitary').checked=false
	document.getElementById('other').checked=false
	document.getElementById('name').value=""
	document.getElementById('autocomplete').value=""
	document.getElementById('name').value=""
	document.getElementById('mail').value=""
	document.getElementById('phone').value=""
	document.getElementById('adressInput').value=""
	document.getElementById('autocomplete').value=""
	document.getElementById('bio').value=""
	location.reload();
})
.catch(function(error) {
	console.error("Error adding document: ", error);
	
});
}

function showonmap(){
	dashb()
	console.log(abcd)
	//map.setCenter(new google.maps.LatLng(t['lati'],t['lngi']));
	//map.setZoom(17)

}
var abcd=[]
function showcard(){
	function createCard(t){
		var card=`<div class="wrapper" style="background: url(./assets/img/${t['type']}.jpg) no-repeat center center">`+
		'<div class="container">'+
			'<div class="top"></div>'+
				'<div class="bottom">'+

					'<div class="left1 ">'+
						'<div class="details">'+
							`<h1>${t['type']}</h1>`+
						'</div>'+
						'<div class="buy">'+
						'<button class="btn btn-one container-1" onclick="showonmap()"></button>'+
						'</div>'+
					'</div>'+
					
				'</div>'+
			'</div>'+
			'<div class="inside">'+
				'<div class="icon"><i class="material-icons">info_outline</i></div>'+
					'<div class="contents">'+
						'<table>'+
							'<tr>'+
							  '<th>Provided By-</th>'+
							'</tr>'+
							'<tr>'+
							  `<td>${t['name']}</td>`+
							'</tr>'+
							'<tr>'+
							  '<th>Email id-</th>'+
							'</tr>'+
							'<tr>'+
							  `<td>${t['mail']}</td>`+
							'</tr>'+
							'<tr>'+
							  '<th>Phone No.</th>'+
							'</tr>'+
							'<tr>'+
								`<td>${t['phone']}</td>`+
							'</tr>'+
							'<tr>'+
							  '<th>Street Address</th>'+
							'</tr>'+
							'<tr>'+
							  `<td>${t['street']}</td>`+
							'</tr>'+
							'<tr>'+
							  '<th>Street Address</th>'+
							'</tr>'+
							'<tr>'+
							  `<td>${t['street']}</td>`+
							'</tr>'+
							'<tr>'+
							  '<th>Description</th>'+
							'</tr>'+
							'<tr>'+
							  `<td>${t['Description']}</td>`+
							'</tr>'+
						'</table>'+
					'</div>'+
				'</div>'+
			'</div>'+
		'</div>'
		
		return card
	}
	var t={}
		var db=firebase.firestore();
		db.collection("markers").get().then((querySnapshot) => {
			querySnapshot.forEach((doc) => {
				t['type']=doc.data()['type']
				t['name']=doc.data()['name']
				t['mail']=doc.data()['email']
				t['phone']=doc.data()['phone']
				t['street']=doc.data()['street']
				t['Description']=doc.data()['Description']
				t['lati']=doc.data()['latitude']
				t['lngi']=doc.data()['longitude']
				abcd.push(t)
				console.log(t)
				document.getElementById('ViewMarker').innerHTML=document.getElementById('ViewMarker').innerHTML+createCard(t)
			});
		});
	}	
showcard()