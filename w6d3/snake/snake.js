var SnakeGame = (function (Sn) {

  Sn.Snake = function Snake (direction) {
		this.head = false;
		this.direction = direction;
		this.pos;
  };

	Sn.Snake.prototype.turn = function(direction) {
		this.direction = direction;
	};

  return Sn;
})(SnakeGame || {});