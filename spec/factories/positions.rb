
FactoryGirl.define do
  factory :position do
    name { FFaker::Name.name }
  end
end

# FactoryGirl.define do
#   factory :traveler do
#     first_name { FFaker::Name.first_name }
#     last_name { FFaker::Name.last_name }
#     birthday { FFaker::IdentificationESCO.expedition_date }
#     gender { FFaker::Gender.maybe }
#   end
# end