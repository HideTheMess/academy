var SnakeGame = (function (Sn) {

  Sn.Plane = function Plane(height, width) {
		this.snake = [];
		this.height = height;
		this.width = width;
		this.plane = [];
  };

	Sn.Plane.prototype.step = function () {

	};

	Sn.Plane.prototype.newPlane = function () {
		var newPlane = [];

		for (var i = 0; i < this.height; i++) {
			var newRow = [];

			for (var j = 0; j < this.width; j++) {
				newRow.push(null);
			}
			newPlane.push(newRow);
		}
		console.log(newPlane);
		return newPlane;
	};

  return Sn;
})(SnakeGame || {});