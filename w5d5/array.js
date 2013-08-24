Array.prototype.uniq = function () {
  var uniq_array = [];

  for (var i = 0; i < this.length; i++) {
    if (!uniq_array.include(this[i])) {
      uniq_array.push(this[i]);
    }
  }

  return uniq_array;
};

Array.prototype.include = function (value) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] === value) {
      return true;
    }
  }

  return false;
};

// console.log([1, 2, 1, 3, 3].uniq());

Array.prototype.two_sum = function () {
  sums_array = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] == 0) {
        sums_array.push([i, j]);
      }
    }
  }

  return sums_array;
};

console.log([-1, 0, 2, -2, 1].two_sum());