class Position
  attr_accessor :turn, :ind_array

  def initialize(turn, ind_array)
    @turn = turn
    @ind_array = ind_array
  end

  def self.generate_ind(ms_x, ms_y)
    #return an array of x and y coordinate, each ranging from 1, 2, 3
    default_array = [0, 0]
    [ms_x, ms_y].each_with_index do |ms, i|
      if ms.to_f < 200
        default_array[i] = 1
      elsif
        ms.to_f < 400
        default_array[i] = 2
      elsif
        ms.to_f < 600
        default_array[i] = 3
      end
    end
    default_array
  end

  def self.generate_turn(turn_counter)
    ['x', 'o'][turn_counter % 2]
  end

  def self.end?(positions)
    x_ind = []
    o_ind = []
    x_number_of_appearances = []
    o_number_of_appearances = []
    positions.each do |pos|
      pos.turn == 'x' ? (x_ind << pos.ind_array) : (o_ind << pos.ind_array)
    end
    #check same row or column
    [1, 2, 3].each do |num|
      x_number_of_appearances << x_ind.count { |ind| ind[0] == num }
      x_number_of_appearances << x_ind.count { |ind| ind[1] == num }
    end
    return 'x' if x_number_of_appearances.include? 3

    [1, 2, 3].each do |num|
      o_number_of_appearances << o_ind.count { |ind| ind[0] == num }
      o_number_of_appearances << o_ind.count { |ind| ind[1] == num }
    end
    return 'o' if o_number_of_appearances.include? 3
    #check diagonal
    return 'x' if ([[1, 1], [2, 2], [3, 3]] - x_ind).empty? || ([[1, 3], [2, 2], [3, 1]] - x_ind).empty?
    return 'o' if ([[1, 1], [2, 2], [3, 3]] - o_ind).empty? || ([[1, 3], [2, 2], [3, 1]] - o_ind).empty?
    return 'tie' if (x_ind.size + o_ind.size) == 9
  end
end
