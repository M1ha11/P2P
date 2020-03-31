class CardDateValidator < ActiveModel::Validator
  def validate(card)
    return unless card.expire_date.present?

    begin
      Date.parse(card.expire_date).strftime('%m/%Y')
    rescue ArgumentError
      card.errors.add(:expire_date, :invalid)
    end
  end
end
