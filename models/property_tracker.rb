require('pg')
require('pry')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :buy_let_status
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @buy_let_status = options['buy_let_status']
    @id = options['id'].to_i if options['id']
  end


  def save #Connection String
    #
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    #VALUES ("Kevin", "Jones", 2, "Bacon") PREVIOUSLY
    sql = "
    INSERT INTO properties
    (address,
      value,
      number_of_bedrooms,
      buy_let_status
    )
    VALUES
    ($1, $2, $3, $4)
    RETURNING *
    "
    values = [@address, @value, @number_of_bedrooms, @buy_let_status]

    db.prepare("save", sql)
    # binding.pry
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end
  #
  # DELETE ALL
  def Property.delete_all
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  # Update Existing

  def update
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "
    UPDATE properties
    SET
    (
      address,
      value,
      number_of_bedrooms,
      buy_let_status
    )
    =
    ($1, $2, $3, $4)
    WHERE id = $5
    "

    values = [@address, @value, @number_of_bedrooms, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end


  # FIND BY ID

  def Property.find(id_to_find)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id_to_find]
    db.prepare("find", sql)
    property = db.exec_prepared("find", values)
    db.close()
    return Property.new(property[0])
  end

  # FIND BY ADDRESS

  def Property.find_address(address_to_find)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address_to_find]
    db.prepare("find", sql)
    property = db.exec_prepared("find", values)
    db.close()
    return Property.new(property[0])
  end



end
