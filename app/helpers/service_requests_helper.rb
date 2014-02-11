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
  
  def item_type_options
    [
      ['Controller', 'Controller'],
      ['Pad', 'Pad']
    ]
  end
end