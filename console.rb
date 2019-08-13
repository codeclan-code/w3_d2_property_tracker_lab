require('pry')

require_relative('./models/property_tracker')

# Property.delete_all()

property1 = Property.new({
  'address' => '50 Edinburgh Terrace',
  'value' => '20000',
  'number_of_bedrooms' => '2',
  'buy_let_status' => 'for sale'
  })

  property2 = Property.new({
    'address' => '2 Castle Terrace',
    'value' => '1500',
    'number_of_bedrooms' => '3',
    'buy_let_status' => 'to let'
    })

    property1.save()
    property2.save()

    # Property.delete_all()
    # property1.number_of_bedrooms = '5'
    property1.update()
    #
    # Property.find(22)
  # p Property.find(48)

  p Property.find_address('50 Edinburgh Terrace')
    # binding.pry
    # nil
