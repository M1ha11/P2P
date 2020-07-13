class AddLocaleToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :locale, :string, null: false, default: 'en', limit: 10
  end
end
