require 'faker'

FactoryGirl.define do
  factory :url do |url|
    url.stub { Faker::Lorem.word + Faker::Number.number(3).to_s }
    
    # to_create do |instance|
      # instance.save(validate: false)
    # end 
  end
end