class CardNumberValidator < ActiveModel::Validator
  def validate(card)
    return unless card.card_number.present?

    card_number = card.card_number.gsub(' ', '').split('').map(&:to_i)
    card_number_sum = card_number_sum(card_number)
    card.errors.add(:card_number, :invalid) if card_number_sum.sum % 10 != 0
  end

  private

  def card_number_sum(card_number)
    card_number_sum = []
    card_number.each_with_index do |number, index|
      if index.even?
        double_number = number * 2
        card_number_sum << ((double_number > 9) ? (double_number - 9) : double_number)
      else
        card_number_sum << number
      end
    end
    card_number_sum
  end
end
