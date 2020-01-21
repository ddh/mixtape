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


      # 3. Iterate through the changes of the
      # TODO: make the changes. Maybe through MixtapeManager or each 'model'


      # 4. Organize the data to be written:
      output_hash = {
        "users": @users.map(&:to_h),
        "playlists": @playlists.map(&:to_h),
        "songs": @songs.map(&:to_h)
      }


      # 5. Write to output file
      Services::FileManager.write_to_file(output_hash, "output.json")

    end
    default_task :change # Makes it so this command runs by default without having to specify it


  end
end