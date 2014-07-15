module OrdersHelper
  def order_items(client_name = nil)
    client_name = "arciplex" if client_name.nil?

    yaml = YAML.load_file("#{Rails.root}/config/client_order_options.yml")
    client_yaml = yaml[client_name]

    if client_yaml
      client_yaml["types"]
    else
      YAML.load_file("#{Rails.root}/config/client_order_options.yml")["arciplex"]["types"]
    end
  end
end
