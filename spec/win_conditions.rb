module Connect4WinConditions
  def permutations
    wins = []

    wins << horizontal

    wins << vertical

    wins << diagonal

    wins.flatten(1)
  end
  def diagonal
    arr = []
    x = [0, 1, 2, 3, 7, 8, 9, 10, 14, 16, 17]
    y = [3, 4, 5, 6, 10, 11, 12, 13, 17, 18, 19, 20]
    (0..20).each do |i|
      if x.include?(i) && y.include?(i)
        arr << [i, i + 8, i + 16, i + 24]
        arr << [i, i + 6, i + 12, i + 18]
      elsif x.include?(i)
        arr << [i, i + 8, i + 16, i + 24]
      else
        arr << [i, i + 6, i + 12, i + 18]
      end
    end
    arr
  end

  def vertical
    arr = []
    (0..20).each {|i| arr << [i, i+7, i+14, i+21]}
    arr
  end

  def horizontal
    arr = []
    d, y = 0, 0
    while d < 42
      arr << [d, d + 1, d + 2, d + 3]
      d += 1 and y += 1
      d += 3 and y = 0 if y == 4
    end
    arr
  end
end
