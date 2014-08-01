module IntegrationHelper
  def sign_in_with(email, password)
    visit root_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end

  def fill_out_sr_form(product_concern: true)
    within "#new_service_request" do
      fill_in "Prefix", with: "Mr"
      fill_in "First name", with: "Foo"
      fill_in "Last name", with: "Bar"
      fill_in "Contact email", with: "foo@baz.com"
      fill_in "Telephone", with: "111-222-3333"
      fill_in "Address", with: "100 Nash Blvd"
      fill_in "City", with: "Some City"
      fill_in "State", with: "TN"
      fill_in "Zip code", with: "11111"
      fill_in "Country", with: "USA"
      fill_in "Product Concern", with: "It Broke" if product_concern
      select("Invention", from: "Type")
      fill_in "Model", with: "ModelA"
      fill_in "Serial number", with: "12345"
      fill_in "Additional information", with: "Additional Info"
      click_button "Submit"
    end
  end
end
