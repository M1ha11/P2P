class ClaimSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :url, :model_name

  def url
    claim_url(object.id, host: ENV['SERVER_HOST'])
  end
end
