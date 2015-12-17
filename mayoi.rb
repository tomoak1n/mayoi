#!/bin/env ruby

N = ARGF.read.to_i

$known_val=Hash.new
class Doro
  def initialize(max_turn)
    @turnpossible = max_turn
    @curpos = -1
    @direction = 1
  end
  def move(turn_or_straight)
    if turn_or_straight == 1 # turn
      if @curpos != -1 && @turnpossible > 0
        @turnpossible -= 1
        @direction *= -1
      else
        return 'F'
      end
    end
    if @curpos == -1
      @curpos = 2 # 'B'
      return @curpos
    end
    @curpos += @direction
    return @curpos
  end
  attr_accessor :curpos, :direction, :turnpossible
  def dup
    newdoro = Doro.new(@turnpossible)
    newdoro.curpos = @curpos
    newdoro.direction = @direction
    return newdoro
  end
end

def search(doro)
  p = 0
  return p if doro == nil
  status = [doro.turnpossible, doro.curpos, doro.direction]
  if $known_val[status] != nil 
    return $known_val[status]
  end
  d1 = doro.dup
  c = d1.move(0)
  if c == 0 
    p += 1
  elsif c < 4
    p += search(d1)
  end
  d = doro.move(1)
  if d == 'F' || d == 4
  elsif d == 0
    p += 1
  else
    p += search(doro)
  end
  $known_val[status] = p
  return p
end

doro=Doro.new(N)
puts search(doro)
