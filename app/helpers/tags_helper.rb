module TagsHelper
  def tag_cloud(model_class)
    Tag.where(tagging_type: model_class.to_s)
  end
end