class ClaimSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :url, :model_name, :title

  def url
    claim_url(object.id, host: ENV['SERVER_HOST'], locale: I18n.locale)
  end

  def title
    I18n.t('claim.title')
  end
end
