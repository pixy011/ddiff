require 'tmpdir'

module DDiff
  class FileSystemUnix
    FILE_IGNORE = []

    # PUBLIC METHODS
    def recurse(folder = nil, &block)
      raise ArgumentError, 'Missing block' unless block_given?

      folder = Config.instance.root if folder == nil
      folder += '/*' unless (folder[-2..-1] == '/*' || folder[-1] == '/')
      folder += '*' if folder[-1] == '/'
      Dir.glob(folder) do |entry|
        if File.directory?(entry)
          recurse(entry, &block)
        else
          yield entry unless FILE_IGNORE.include?(entry)
        end
      end
    end
  end
end