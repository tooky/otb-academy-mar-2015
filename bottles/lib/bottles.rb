class Bottles

  def verse(number_of_bottles)
    bottles_left = number_of_bottles - 1
    "#{count_bottles(number_of_bottles).capitalize} #{container(number_of_bottles)} of beer on the wall, "\
      "#{count_bottles(number_of_bottles)} #{container(number_of_bottles)} of beer.\n"\
      "#{action(number_of_bottles)}"\
      "#{count_bottles(bottles_left)} #{container(bottles_left)} of beer on the wall.\n"
  end

  def action(number_of_bottles)
    if number_of_bottles.zero?
      "Go to the store and buy some more, "
    else
      "Take #{pronoun(number_of_bottles)} down and pass it around, "
    end
  end

  def pronoun(number_of_bottles)
    if number_of_bottles == 1
      "it"
    else
      "one"
    end
  end

  def count_bottles(number_of_bottles)
    if number_of_bottles == 0
      "no more"
    elsif number_of_bottles == -1
      "99"
    else
      number_of_bottles.to_s
    end
  end

  def container(number_of_bottles)
    if number_of_bottles == 1
      "bottle"
    else
      "bottles"
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
