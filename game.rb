require 'gosu'
require_relative 'position'

class TicTacToe < Gosu::Window
  def initialize
    @width = 600
    @cell_width = @width / 3
    super @width, @width
    self.caption = "Double Tic Tac Toe"
    @ind_arrays = [] #this array contains index arrays of already occupied positions
    @positions = []
    @turn_counter = 0
    @result = nil
    @x_image = Gosu::Image.new(self, 'media/x.png', false)
    @o_image = Gosu::Image.new(self, 'media/o.png', false)
    @mfont = Gosu::Font.new(self, Gosu::default_font_name, @cell_width / 3)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      new_ind_array = Position.generate_ind(mouse_x, mouse_y)
      unless @ind_arrays.include? new_ind_array
        @ind_arrays << new_ind_array
        @turn_counter += 1
        new_turn = Position.generate_turn(@turn_counter)
        @positions << Position.new(new_turn, new_ind_array)
        @result = Position.end?(@positions)
      end
    when Gosu::KbQ then close
    when Gosu::KbR then initialize
    end
  end

  def draw
    # draw the grid
    [@cell_width, @cell_width * 2].each do |w|
      draw_line(w, 0, Gosu::Color::WHITE, w, @width, Gosu::Color::WHITE)
      draw_line(0, w, Gosu::Color::WHITE, @width, w, Gosu::Color::WHITE)
    end
    # draw positions
    @positions.each do |pos|
      ind = pos.ind_array
      x = (ind[0] * 2 - 1) * 100
      y = (ind[1] * 2 - 1) * 100
      pos.turn == 'x' ? @x_image.draw_rot(x, y, 0, 0) : @o_image.draw_rot(x, y, 0, 0)
    end
    #display messages
    if @result == 'x'
      display_message("X wins")
    elsif @result == 'o'
      display_message("O wins")
    elsif @result == 'tie'
      display_message("Game tied")
    end
  end

  def display_message(txt)
    black = Gosu::Color::BLACK
    draw_quad(0,100,black,
              width, 100, black,
              width, 500, black,
              0, 500, black)
    @mfont.draw(txt, (width-@mfont.text_width(txt))/2, width/2 - 100, 0)
  end
end

TicTacToe.new.show
