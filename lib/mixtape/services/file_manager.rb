module Services
  class FileManager

    DEFAULT_OUTPUT_FILE_NAME = "export/output.json".freeze

    # Returns a hash of the provided json file or default.
    # Defaults to reading the mixtape.json at root of project.
    def self.read_from_file(filename)
      file = File.read(File.expand_path("../../data/#{filename}","#{__dir__}/.."))
      JSON.parse(file)
    end

    # Writes the given hash to specified file or to the default.
    # Writes the file to the root of the project.
    def self.write_to_file(hash = {}, file = nil)
      pretty_hash = JSON.pretty_generate(hash)
      File.write(DEFAULT_OUTPUT_FILE_NAME || file, pretty_hash)
    end

  end
end