FactoryGirl.define do
  factory :order do
    user
    customer
    company
    tracking_number "111"
    carrier "UPS"

    after :create do |order, elevator|
      order.customer = create(:customer)
      order.order_line_items << create(:order_line_item)
    end
  end
end
