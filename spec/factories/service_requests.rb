FactoryGirl.define do
  factory :service_request do
    user
    customer
    company
    troubleshooting_reference "Foo Ref"
    rma "123"
    additional_information "Add Info"

    after :create do |sr, elevator|
      create(:customer)
      sr.line_items << create(:line_item)
    end
  end
end
