module ServiceRequestsHelper
  def troubleshooting_options
    [
      ['SR:E101', 'SR:E101'],
      ['SR:E105', 'SR:E105'],
      ['SR:E110', 'SR:E110'],
      ['SR:E120', 'SR:E120'],
      ['SR:E125', 'SR:E125'],
      ['SR:E130', 'SR:E130'],
      ['SR:E150', 'SR:E150'],
      ['DOA', 'DOA'],
      ['Software Update', 'Software Update'],
      ['Other', 'Other']
    ]
  end

  def item_type_options(client_name = nil)
    client_name = "arciplex" if client_name.nil?

    yaml = YAML.load_file("#{Rails.root}/config/client_sr_options.yml")
    client_yaml = yaml[client_name]

    if client_yaml
      client_yaml["types"]
    else
      YAML.load_file("#{Rails.root}/config/client_sr_options.yml")["arciplex"]["types"]
    end
  end

  def data_attributes(object)
    "data-object-id=#{object.id}" if object.id.present?
  end

  def link_to_remove(object, classes: nil)
    data = {}
    data["object-id"] = object.id if object.id.present?

    link_to("Remove", "#", class: classes, data: data)
  end
end
