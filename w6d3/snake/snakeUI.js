var snakeUI = function () {
	var plane = new SnakeGame.Plane(60, 90);
	plane.plane = plane.newPlane();
	for (var i = 0; i < 2; i++) {
		plane.snake.push(new SnakeGame.Snake());
		plane.snake[i].pos = [30, 1 - i];
	}
	plane.snake[0].head = true;
	plane.snake[0].direction = "east";

	render(plane);
	// gameLoop
	var gameLoop = function () {

	};

	gameLoop();
};

var render = function (plane) {
	$('body').empty();

	for (var i = 0; i < plane.height; i++) {
		$('body').append("<div id='div" + i + "'></div>");
		for (var j = 0; j < plane.width; j++) {
			$('#div' + i).append("<span id='span" + i + "_" + j + "'></span>");
		}
	}
	plane.snake.forEach(function (el) {
		$('#span' + el.pos[0] + '_' + el.pos[1]).addClass('snake');
	});
};

$(snakeUI);