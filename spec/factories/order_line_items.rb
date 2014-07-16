FactoryGirl.define do
  factory :order_line_item do
    item "Controller"
    quantity 1
    additional_information "Additional Info"
    serial_number "ABC123"
  end
end
