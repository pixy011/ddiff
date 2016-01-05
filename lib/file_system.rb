require_relative 'file_system_unix'

module DDiff
  class FileSystem
    def self.create(type = 'unix')
      Object.const_get('DDiff::FileSystem' + type.capitalize()).new
    end

    def self.parse_whitelist(type = 'unix')
      Object.const_get('DDiff::FileSystem' + type.capitalize()).parse_whitelist()
    end
  end
end