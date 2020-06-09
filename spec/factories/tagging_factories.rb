FactoryBot.define do
  factory :tagging do
    tag
    association :taggable, factory: :claim
  end
end