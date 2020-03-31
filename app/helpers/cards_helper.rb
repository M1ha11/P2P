module CardsHelper
  def show_card_number(card)
    "#{card.card_number[0..-5].gsub(/\d/, '*')} #{card.card_number.last(4)}"
  end
end
