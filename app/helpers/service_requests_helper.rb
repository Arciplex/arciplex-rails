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
    if client_name.blank?
      client_name = current_user.company_name.downcase
    end

    yaml = YAML.load_file("#{Rails.root}/config/client_sr_options.yml")

    yaml[client_name]["types"]
  end
end