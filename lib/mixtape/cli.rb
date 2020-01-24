require 'thor'

module Mixtape
  class CLI < Thor

    desc "<mixtape.json> <changes.json> <output.json>", "Makes changes to a mixtape json file."
    def change(source_file, changes_file, output_file)

      # 1. Retrieve data from file inputs
      source_hash = Services::FileManager.read_from_file(source_file)
      changes_hash = Services::FileManager.read_from_file(changes_file)


      # 2. Load data into memory; order matters here where songs and users need to be loaded first before playlists
      @songs = MixtapeManager.load_songs(source_hash["songs"])
      @users = MixtapeManager.load_users(source_hash["users"])
      @playlists = MixtapeManager.load_playlists(source_hash["playlists"])

      # 3. Iterate through the changes, making changes to internally instantiated data
      changes_hash["playlists"].each do |playlist_changes|

        playlist_id = playlist_changes["id"]
        user_id = playlist_changes["user_id"]
        song_ids = playlist_changes["song_ids"]

        # a. Adding existing song to existing playlist == id.present? && songs.present?
        if playlist_id && song_ids
          song_ids.each do |song_id|
            Playlist.find(playlist_id).add_song(song_id)
          end
        end

        # b. Add new playlist (with at least one song) to existing user == user_id.present? && id.nil? && songs.present?
        if user_id && song_ids
          Playlist.new(playlist_changes).save
        end

        # c. Remove existing playlist == id.present? && user_id.nil?
        if playlist_id && playlist_changes.has_key?("user_id") && user_id.nil?
          Playlist.destroy(playlist_id)
        end
      end


      #4. Reload playlists from internal memory, as there may be changes now
      @playlists = Playlist.all

      # 4. Organize the data to be written:
      output_hash = {
        "users": @users.map(&:to_h),
        "playlists": @playlists.map(&:to_h),
        "songs": @songs.map(&:to_h)
      }


      # 5. Write to output file
      Services::FileManager.write_to_file(output_hash, output_file)

    end
    default_task :change # Makes it so this command runs by default without having to specify it


  end
end