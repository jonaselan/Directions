FactoryGirl.define do
  factory :place do
    name "Local X"
    latitude  0
    longitude 0
    initials "X"
    address "myString"
    number "myString"
    neighborhood "myString"

    factory :invalid_place do
      name nil
    end
  end
end
