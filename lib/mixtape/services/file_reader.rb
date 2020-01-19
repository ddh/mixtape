module Services
  class FileReader

    # Returns a hash of the .json file passed in.
    # Defaults to reading the mixtape.json at root of project
    def self.read_from_json(file = nil)
      file = File.read(file || File.expand_path("../../mixtape.json","#{__dir__}/.."))
      JSON.parse(file)
    end

  end
end