class TagSerializer < ApplicationSerializer
  attributes :id, :name, :url, :model_name

  def url
    claims_url(tag: object.name, host: ENV['SERVER_HOST'])
  end
end
