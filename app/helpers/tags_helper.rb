module TagsHelper
  def cloud(model_class)
    Tag.for_entity(model_class).distinct.pluck(:name)
  end
end
