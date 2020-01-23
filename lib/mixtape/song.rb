class Song

  @@songs = []

  attr_accessor :id, :artist, :title

  def initialize(params = {})
    @id = params['id']
    @artist = params['artist']
    @title = params['title']
  end

  def save
    @@songs << self
  end

  def to_h
    {
      "id": @id,
      "artist": @artist,
      "title": @title
    }
  end

  def self.all
    @@songs
  end

  def self.find(id)
    all.find { |object| object.id == id }
  end

end