# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(50)       not null
#
class TagSerializer < ApplicationSerializer
  attributes :id, :name, :url, :model_name

  def url
    claims_url(tag: object.name, host: ENV['SERVER_HOST'], locale: I18n.locale)
  end
end
