require 'tmpdir'

module DDiff
  class FileSystemUnix
    FILE_IGNORE = []

    class << self
      def parse_whitelist()
        raise StandardError, "Whitelist file not found #{DDiff::Config.instance.whitelist_file}" unless
            File.exist?(DDiff::Config.instance.whitelist_file)

        File.read(DDiff::Config.instance.whitelist_file).gsub("\r", "\n").gsub(/\n{2,}+/, "\n").split("\n")
      end
    end

    # PUBLIC METHODS
    def walk(&block)
      raise StandardError, "No paths to scan" if Config.instance.paths == nil
      Config.instance.paths.each { |path| _recurse(path, &block)}
    end

  private
    def _recurse(folder = nil, &block)
      raise ArgumentError, 'Missing block' unless block_given?

      folder = Config.instance.root if folder == nil
      folder += '/*' unless (folder[-2..-1] == '/*' || folder[-1] == '/')
      folder += '*' if folder[-1] == '/'
      Dir.glob(folder) do |entry|
        if File.directory?(entry)
          _recurse(entry, &block)
        else
          yield entry unless FILE_IGNORE.include?(entry)
        end
      end
    end
  end
end