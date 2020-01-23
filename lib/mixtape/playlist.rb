class Playlist

  @@playlists = []
  @@id_to_assign = "1" # Keeps track of what new playlist ids should be

  attr_reader :id, :user, :songs

  def initialize(params = {})
    @id = params["id"]
    @user_id = params["user_id"]
    @song_ids = params["song_ids"] || []
  end

  def save
    @user = User.find(@user_id)
    @songs = @song_ids.map do |song_id|
      Song.find(song_id)
    end

    self.class.assign_instance_id(self)
    @@playlists << self
  end

  def add_songs(song_ids)
    # TODO: Add songs from playlist
  end

  def remove_songs(song_ids)
    # TODO: Remove songs from playlist
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

  # Assigns primary id
  def self.assign_instance_id(object)
    object.id ||= @@id_to_assign
    @@id_to_assign = [object.id.next, @@id_to_assign.next].max # Takes max to avoid id collisions
    return object.id
  end

end
