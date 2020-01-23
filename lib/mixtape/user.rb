class User

  @@users = []

  attr_accessor :id, :name

  def initialize(params = {})
    @id = params['id']
    @name = params['name']
  end

  def save
    @@users << self
  end

  def to_h
    {
      "id": @id,
      "name": @name
    }
  end

  def self.all
    @@users
  end

  def self.find(id)
    all.find { |object| object.id == id }
  end

  def self.all
    @@users
  end

end