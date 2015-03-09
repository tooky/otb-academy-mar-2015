class BottleNumber
  
  def initialize(number_of_bottles)
    @number_of_bottles = number_of_bottles
  end
  
  def pronoun
    if @number_of_bottles == 1
      "it"
    else
      "one"
    end
  end
  
  def count_bottles
    if @number_of_bottles == 0
      "no more"
    else
      bottle_left_number
    end
  end
  
  def bottle_left_number
    if @number_of_bottles == -1
      99
    else
      @number_of_bottles.to_s
    end
  end
  
  def container
    if @number_of_bottles == 1
      "bottle"
    else
      "bottles"
    end
  end
  
  def action
    if @number_of_bottles.zero?
      "Go to the store and buy some more, "
    else
      "Take #{pronoun} down and pass it around, "
    end
  end
  
  def bottles_left_count
    BottleNumber.new(@number_of_bottles - 1).count_bottles
  end
  
  def bottles_left_container
    BottleNumber.new(@number_of_bottles - 1).container
  end
  
end

class Bottles

  def verse(number_of_bottles)
    bottle_number = BottleNumber.new(number_of_bottles)
    "#{bottle_number.count_bottles.capitalize} #{bottle_number.container} of beer on the wall, "\
    "#{bottle_number.count_bottles} #{bottle_number.container} of beer.\n"\
    "#{bottle_number.action}"\
    "#{bottle_number.bottles_left_count} #{bottle_number.bottles_left_container} of beer on the wall.\n"
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
