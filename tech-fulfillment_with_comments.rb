# What is this?
  # 'f' is a recursive function. It takes in some params (described below)
  # and builds a 2D array of 0's. From there, we find a grid centerpoint,
  # rounding down, and begin to build a spiral. A guard clause makes sure
  # we're not trying to operate out of bounds, and builds a spiral by incrementing
  # the length of the spiral arm while also cycling through a predetermined
  # list of directional commands.
#
# Params:
# l:
  # - The length of the current arm of the spiral.
  # - Starts at 2 and incrementally gets longer by one on each directional change
#
# d: directions
  # - An array of arrays.
  # - Each sub array contains offsets to add to the coordinate when moving in a direction
#
# a: directional input
  # - An integer that increments on each iteration.
  # - Capped at 3, then returning to zero with modulo math.
  # - This dictates which directional offset from "d" we should be working with for grid traversal
#
# o: output
  # - This is our grid.
  # - It starts as a 2D array, with each element defaulting to 0
  # - As we recursively build out, 0 is replaced with 1 to build a spiral
#
# r: row
  # - A value to determine which row we work with in the 2D array.
#
# c: column
  # - A value to determine which column we work with in the 2D array
def f(l, d, a, o, r, c)
  # length of the spiral arm for this iteration of "f"
  l.times { | i |
    # guard clause. don't color outside of the lines.
    return o if !o.dig(r, c)|| c < 0 || r < 0

    # set our first point as 1. on the first iteration, this is our identifed midpoint of the grid
    o[r][c] = 1

    # We don't want to do this on the last iteration
    r, c = [r, c].zip(d[a]).map(&:sum) if i < l - 1
  }

  # recursive call.
  # next spiral length is l + 1.
  # directional offsets are static
  # a is a pointer to d. it can't be larger than the index of the last element, which is 3.
  # o is modified and passed along
  # r and c are also modified and passed along
  o = f(l + 1, d, (l - 1) % 4, o, r, c)
end

def test
  inputs = [[3, 4], [4, 3], [4, 5], [5, 4], [7, 6], [5, 15], [15, 15], [15, 5], [3, 3], [1, 1]]

  inputs.each do |c,r|
    result = f(2, [[1, 0], [0, 1], [-1, 0], [0, -1]], 0, Array.new(r) {[0]*c}, (r-1) / 2, (c-1) / 2)
    result.each do |row|
      print row.join " "
      print "\n"
    end

    print "\n"
  end
end

test
