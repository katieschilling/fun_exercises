var legend = { 1: 'x', 2: 'o' };
var winningSquares = [
	[0, 1, 2], [3, 4, 5], [6, 7, 8],
	[0, 3, 6], [1, 4, 7], [2, 5, 8],
	[0, 4, 8], [2, 4, 6]
]

window.onload = function(){
	squares = document.getElementsByTagName('td');
	squares = [].slice.call(squares); // [] is shorthand for Array.prototype. Need this to call filter() later.

	player.value = 1;

	player.onclick = switchPlayer;

	for(var i = 0; i < squares.length; i++){
		squares[i].onclick = function() {
			if (player.value)
				play(this);
			else 
				console.log('error');
		}
	}
}

function switchPlayer(){
	if (player.value == 1){
		player.value = 2;
		player.innerHTML = "Player 2";
	}
	else {
		player.value = 1;
		player.innerHTML = "Player 1";
	}
}

function play(square) {
	if (square.className) alert("Already been played");
	else {
		square.className = legend[player.value];

		checkWinner();

		switchPlayer();
	}
}

function checkWinner(){

	for(var i = 0; i < winningSquares.length; i++){
		var filtered = squares.filter(function(element, index){
			return winningSquares[i].indexOf(index) > -1 
						 && element.className == legend[player.value];
		});

		if (filtered.length == 3)
			alert(player.innerHTML + " wins!");
	}
}
