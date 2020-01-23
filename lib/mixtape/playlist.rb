class Playlist

  @@playlists = []
  @@id_to_assign = "1" # Keeps track of what new playlist ids should be

  attr_reader :id, :user, :songs

  def initialize(params = {})
    @id = params["id"]
    @user_id = params["user_id"]
    @song_ids = params["song_ids"].uniq || []
  end

  def save
    @user = User.find(@user_id)
    @songs = @song_ids.map do |song_id|
      song = Song.find(song_id)
      raise ArgumentError.new("Song (id: #{song_id}) does not exist!") if song.nil?
      song
    end

    self.class.assign_instance_id(self)
    @@playlists << self
  end

  # TODO: Remove coupling to Song class
  def add_song(song_id)
    song = Song.find(song_id)

    raise ArgumentError.new("Song (id: #{song_id}) was not found for the given.") if song.nil?
    raise ArgumentError.new("Song (id: #{song_id}) was already in the playlist.") if @song_ids.include?(song_id)

    @song_ids << song_id
    @songs << song
  end

  def to_h
    {
      "id": @id,
      "user_id": @user_id,
      "song_ids": @song_ids
    }
  end

  def self.all
    @@playlists
  end

  def self.find(id)
    all.find { |object| object.id == id }
  end

  def self.destroy(id)
    destroyed_object = find(id)
    all.reject! { |object| object.id == destroyed_object.id }
  end

  # Assigns primary id
  def self.assign_instance_id(object)
    object.instance_variable_set(:@id, @@id_to_assign) unless object.id
    @@id_to_assign = [object.id.next, @@id_to_assign.next].max # Takes max to avoid id collisions
    return object.id
  end

end
