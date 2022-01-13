FactoryBot.define do
  factory :discount do
    discount_type { 1 }
    code { "MyString" }
    min_quantity { 2 }
  end
end
