class ClaimSerializer < ApplicationSerializer
  attributes :id, :amount, :currency, :url

  def url
    claim_url(object.id, host: 'localhost:3000')
  end
end
