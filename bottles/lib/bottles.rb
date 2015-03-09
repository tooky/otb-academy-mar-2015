class Bottles

  def verse(number_of_bottles)
    case number_of_bottles
    when 2 then
      "#{number_of_bottles} bottles of beer on the wall, #{number_of_bottles} bottles of beer.\nTake one down and pass it around, #{number_of_bottles - 1} bottle of beer on the wall.\n"
    when 1
      "#{number_of_bottles} bottle of beer on the wall, #{number_of_bottles} bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    else
      "#{number_of_bottles} bottles of beer on the wall, #{number_of_bottles} bottles of beer.\nTake one down and pass it around, #{number_of_bottles - 1} bottles of beer on the wall.\n"
    end
  end

  def verses(high, low )
    high.downto(low).map do |bottles|
      verse(bottles)
    end.join("\n") + "\n"
  end

  def sing
    verses(99, 0)
  end

end
