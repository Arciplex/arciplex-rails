module OrdersHelper
  def order_items(client_name = nil)
    client_name = current_user.company_name.downcase if client_name.blank?

    yaml = YAML.load_file("#{Rails.root}/config/client_order_options.yml")

    yaml[client_name]["types"]
  end
end
