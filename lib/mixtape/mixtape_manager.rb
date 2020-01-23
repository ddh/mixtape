class MixtapeManager

  def self.load_playlists(playlists = [])
    playlists.each do |playlist|
      Playlist.new(playlist).save
    end
    return Playlist.all
  end

  def self.load_songs(songs = [])
    songs.each do |song|
      Song.new(song).save
    end
    return Song.all
  end

  def self.load_users(users = [])
    users.each do |user|
      User.new(user).save
    end
    return User.all
  end

end