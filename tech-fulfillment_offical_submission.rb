# Copy this into a rails console and you should see all test cases printed out

def f(l, d, a, o, r, c)
  l.times { | i |
    return o if !o.dig(r, c) || c < 0 || r < 0
    o[r][c] = 1
    r, c = [r, c].zip(d[a]).map(&:sum) if i < l - 1
  }
  o = f(l + 1, d, a == 3 ? 0 : a + 1, o, r, c)
end

def test
  inputs = [[3, 4], [4, 3], [4, 5], [5, 4], [7, 6], [5, 15], [15, 15], [15, 5], [3, 3], [1, 1]]

  inputs.each do |input|
    result = f(2, [[1, 0], [0, 1], [-1, 0], [0, -1]], 0, Array.new(input[1]) { Array.new(input[0], 0) }, (input[1]-1) / 2, (input[0]-1) / 2)
    result.each do |row|
      print row.join " "
      print "\n"
    end

    print "\n"
  end
end

test
