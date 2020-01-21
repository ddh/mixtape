class Playlist

  @@playlists = []

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
    @@playlists << self
  end

  def self.all
    @@playlists
  end


  def add_songs(song_ids)
    # TODO: Add songs from playlist
  end

  def remove_songs(song_ids)
    # TODO: Remove songs from playlist
  end

end
