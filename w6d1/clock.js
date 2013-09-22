var Clock = function () {};

Clock.prototype.run = function () {
  var dat = this;

  var time = new Date(Date.now());

  setInterval(function () {
    var hours = dat.forceTwoDigit(time.getHours().toString());
    var minutes = dat.forceTwoDigit(time.getMinutes().toString());
    var seconds = dat.forceTwoDigit(time.getSeconds().toString());

    console.log(hours + ':' + minutes + ':' + seconds);
  },
  5000);
};

Clock.prototype.tick = function(time) {
  
};

Clock.prototype.forceTwoDigit = function(number) {
  while (number.length < 2)
    number = '0' + number;

  return number;
};

var clock = new Clock();
clock.run();