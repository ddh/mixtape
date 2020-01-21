module Services
  class FileManager

    DEFAULT_INPUT_FILE_NAME = "mixtape.json".freeze
    DEFAULT_OUTPUT_FILE_NAME = "output.json".freeze

    # Returns a hash of the provided json file or default.
    # Defaults to reading the mixtape.json at root of project.
    def self.read_from_file(filename = nil)
      file = File.read(DEFAULT_INPUT_FILE_NAME || File.expand_path("../../mixtape.json","#{__dir__}/.."))
      JSON.parse(file)
    end

    # Writes the given hash to specified file or to the default.
    # Writes the file to the root of the project.
    def self.write_to_file(hash = {}, file = nil)
      pretty_hash = JSON.pretty_generate(hash)
      File.write(DEFAULT_OUTPUT_FILE_NAME || "output.json", pretty_hash)
    end

  end
end