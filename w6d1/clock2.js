var Clock = function () {};

Clock.prototype.run = function () {
  var time = new Date(Date.now());

  setInterval(this.tick(time), 5000);
};

Clock.prototype.tick = function(time) {
  var hours = this.forceTwoDigit(time.getHours().toString());
  var minutes = this.forceTwoDigit(time.getMinutes().toString());
  var seconds = this.forceTwoDigit(time.getSeconds().toString());

  console.log(hours + ':' + minutes + ':' + seconds);
};

Clock.prototype.forceTwoDigit = function(number) {
  while (number.length < 2)
    number = '0' + number;

  return number;
};

var clock = new Clock();
clock.run();