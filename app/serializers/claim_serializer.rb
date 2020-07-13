# == Schema Information
#
# Table name: claims
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  amount            :float            not null
#  currency          :string           not null
#  goal              :string           not null
#  interest_rate     :float            not null
#  repayment_period  :string           not null
#  payment_frequency :string           not null
#  user_id           :bigint           not null
#  status            :string           default("publicly"), not null
#  confirmed_at      :datetime
#
class ClaimSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :url, :model_name, :title

  def url
    claim_url(object.id, host: ENV['SERVER_HOST'], locale: I18n.locale)
  end

  def title
    I18n.t('claim.title')
  end
end
