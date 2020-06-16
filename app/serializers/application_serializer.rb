class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  def model_name
    object.class.name
  end
end
