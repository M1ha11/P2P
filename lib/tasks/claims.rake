namespace :claims do
  desk 'TODO'
  task archive: :environment do
    Claims::Archive.call
  end
end