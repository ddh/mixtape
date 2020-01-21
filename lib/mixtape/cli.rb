require 'thor'

module Mixtape
  class CLI < Thor
    desc "<mixtape.json> <changes.json> <output.json>", "Makes changes to a mixtape json file."
    def change(source_file, changes_file, output_file)

      # Retrieve data from file inputs
      source_hash = Services::FileManager.read_from_file(source_file)
      changes_hash = Services::FileManager.read_from_file(changes_file)


      # Load data into memory; order matters here where songs and users need to be loaded first before playlists
      @songs = MixtapeManager.load_songs(source_hash["songs"])
      @users = MixtapeManager.load_users(source_hash["users"])
      @playlists = MixtapeManager.load_playlists(source_hash["playlists"])
      binding.pry

      # @playlists.find()
      # @songs.find()
      # @users.find()
    end
    default_task :change

  end
end