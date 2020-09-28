# frozen_string_literal: true

# class to define the knight's movements
class Knight
  attr_accessor :path
  def initialize(path = [])
    @path = path
  end

  def valid?(position)
    return false if position[0].negative? || position[1].negative? || position[0] > 7 || position[1] > 7

    true
  end

  def possible_moves(pos)
    moves = []
    moves << [pos[0] + 1, pos[1] + 2]
    moves << [pos[0] + 2, pos[1] + 1]
    moves << [pos[0] + 2, pos[1] - 1]
    moves << [pos[0] + 1, pos[1] - 2]
    moves << [pos[0] - 1, pos[1] - 2]
    moves << [pos[0] - 2, pos[1] - 1]
    moves << [pos[0] - 1, pos[1] + 2]
    moves << [pos[0] - 2, pos[1] + 1]
    moves.select { |move| valid?(move) }
  end

  def play(start = [], dest = [])
    until valid?(start) && valid?(dest)
      puts 'Enter start position X coordinate between 0 and 7'
      start[0] = gets.chomp.to_i
      puts 'Enter start position Y coordinate between 0 and 7'
      start[1] = gets.chomp.to_i
      puts 'Enter destination position X coordinate between 0 and 7'
      dest[0] = gets.chomp.to_i
      puts 'Enter destination position Y coordinate between 0 and 7'
      dest[1] = gets.chomp.to_i
    end
    if start == dest
      puts ' Start same as destination'
    else
      @path = knight_moves(start, dest)
      puts "Knight moves from #{start} tp #{dest} in #{@path.length} moves. The path is #{@path}"
    end
  end

  def knight_moves(start, dest)
    path = [start]
    queue = possible_moves(start).map { |move| path + [move] }
    until queue.empty?
      path = queue.shift
      break if path[-1] == dest

      queue += possible_moves(path[-1]).map { |move| path + [move] }
    end
    path
  end
end

game1 = Knight.new
game1.play
