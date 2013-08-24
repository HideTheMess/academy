var snakeUI = function () {
	var plane = new SnakeGame.Plane(20, 30);
	plane.plane = plane.newPlane();

	while (plane.apples.length == 0) {
		plane.placeApple();
	}

	for (var i = 0; i < 2; i++) {
		plane.snake.push(new SnakeGame.Snake());
		plane.snake[i].pos = [9, 1 - i];
	}
	plane.snake[0].head = true;
	plane.snake[0].direction = "east";

	$('html').keydown(function (event) {
	  console.log("You pressed keycode: " + event.keyCode);
		switch (event.keyCode) {
		case 38:
			plane.snake[0].turn('north');
			break;
		case 40:
			plane.snake[0].turn('south');
			break;
		case 37:
			plane.snake[0].turn('west');
			break;
		case 39:
			plane.snake[0].turn('east');
		}
	});

	plane.render();
	// gameLoop
	plane.gameLoop();
};

$(snakeUI);