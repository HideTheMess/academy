def range(start, finish)
  i = start
  arry = []

  until i > finish
    arry << i
    i += 1
  end

  arry
end

def sum_rec(arry)
  return 0 if arry.empty?

  arry[0] + sum_rec(arry[1..-1])
end

def sum_it(arry)
  sum = 0
  arry.each { |num| sum += num }
  sum
end

def exp1(b, n)
  return 1 if n == 0

  b * exp1(b, n - 1)
end

def exp2(b, n)
  return 1 if n == 0

  return exp2(b, n / 2) * exp2(b, n / 2) if n.even?
  b * (exp2(b, (n - 1) / 2) * exp2(b, (n - 1) / 2)) # if n.odd?
end

def bsearch(array, target)
  arry = arry.dup.sort!

  middle = arry.length / 2
  case arry[middle] <=> target
  when 0
    return middle
  when 1
    result = bsearch(arry.take[middle], target)
    return nil if result.nil?
    return middle - (arry.take[middle] - result)
  when -1
    result = bsearch(arry.drop[middle], target)
    return nil if result.nil?
    return middle + result + 1
  end
end
