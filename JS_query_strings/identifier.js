
//Use this function to create and return a random 32 digit identifier
//similar to a Globally unique identifier
	var globalUnique 
	var seeded 
	var shortened


	var createIdentifiers = function() {
		globalUnique = window.location.search.slice(1);;
		seeded = createIdentifierWithSeed(39302948523);
		shortened = shortenIdentifier(globalUnique);

		var globalH1 = document.getElementById("globallyUnique");
		var seededH1 = document.getElementById("seeded");
		var shortenedH1 = document.getElementById("shortened");

		globalH1.innerHTML = "The 32 digit identifier is: " + globalUnique;
		seededH1.innerHTML = "The seeded identifier is: " + seeded;
		shortenedH1.innerHTML = "The shortened identifier is: " + globalUnique;

	};


var create32DigitIdentifier = function() {
	return cuniq(1337);
};
var c = 1;
function cuniq() {
    var d = new Date(),
        m = d.getMilliseconds() + "",
        u = ++d + m + (++c === 10000 ? (c = 20) : c);

    return u;
}

//With this function, assume that there is a globally unique
//visitor ID being passed into the function. Try creating another
//unique ID for that visitor on the website for the specific moment
//in time (to do something like keep track of an action or an order)
var createIdentifierWithSeed = function(seed){
		return cuniq(seed);
};
var c = 1;
function cuniq() {
    var d = new Date(),
        m = d.getMilliseconds() + "",
        u = ++d + m + (++c === 10000 ? (c = 1) : c);

    return u;
};


//Now let's say you can't have an identifier that is 32 digits
//long. You need it to be shorter! Use this function to shorten
//the parameter passed in. Assume the parameter is digits only. 
//(But for an extra challenge, how would you verify this?)
//HINT: the way we count things is in Base 10, but computers can
//count things using a different Base
var shortenIdentifier = function(longIdentifier){
	return null;
};
window.onload= function(){
var button = document.getElementById("yaybutton");
button.onclick=function(){
	globalUnique = create32DigitIdentifier();
	var url = window.location.origin + window.location.pathname + "?" + globalUnique;
	window.location = url;

}
}

// <body>
// var url = document.url
// <button onclick="function">Clickies!</button>
// function function(){
// 	document.write(url);
// }
// </body>
// <button onclick="redirectWithQS()">Clickies!</button>
// redirectWithQS = function function(url, QS){}