# 7カードの確率計算モンテカルロ法

def main
  trial = 100000.0
  a = ((0...trial).map{|v| one_time_card}.select{|v| v == 'safe'}.count/trial)
  puts sprintf( "%.3f", a )
end

def one_time_card
  number_of_cards = 4
  n = number_of_cards - 1
  cards = (0..n).to_a
  cards_open_array = Array.new(number_of_cards, false)
  cards.shuffle!
  first_index = rand(0..n)
  card_number = cards[first_index]
  cards_open_array[first_index] = true
  return open_card(card_number, cards, cards_open_array, n)
end

def open_card(card_number, cards, cards_open_array, n)
  i = card_number
  j = n - card_number
  if cards_open_array.all?
    return 'safe'
  else
    if cards_open_array[i] && cards_open_array[j]
      return 'out'
    elsif cards_open_array[i] && !cards_open_array[j]
      cards_open_array[j] = true
      open_card(cards[j], cards, cards_open_array, n)
    elsif !cards_open_array[i] && cards_open_array[j]
      cards_open_array[i] = true
      open_card(cards[i], cards, cards_open_array, n)
    else
      if rand(0..1) == 0
        cards_open_array[j] = true
        open_card(cards[j], cards, cards_open_array, n)
      else
        cards_open_array[i] = true
        open_card(cards[i], cards, cards_open_array, n)
      end
    end
  end
end


main
