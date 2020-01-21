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

  def self.find(id)
    @@songs.find { |song| song.id == id }
  end

  def self.all
    @@songs
  end

  def to_h
    {
      "id": @id,
      "artist": @artist,
      "title": @title
    }
  end

end