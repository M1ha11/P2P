module I18nEnumHelper
  def enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      [i18n_enum(class_name, enum, key), key]
    end
  end

  def enum_locale(class_name, enum, key)
    i18n_enum(class_name, enum, key)
  end

  private

  def i18n_enum(class_name, enum, key)
    I18n.t("activerecord.attributes.#{class_name.to_s.downcase}.#{enum.to_s.pluralize}.#{key}")
  end
end
