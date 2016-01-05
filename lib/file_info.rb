require 'json'

module DDiff
  class FileInfo
    DETECT_JSON_REGEX = /{.+}/ # Don't need anything fancy here, we're up against paths

    def initialize(initial_value)
      @path = nil
      @stat = Hash.new

      if initial_value.class.name == 'Hash' || initial_value =~ DETECT_JSON_REGEX
        from_json(initial_value)
      else
        @path = initial_value
        _save_file_stat() if initial_value
      end
    end


    # PUBLIC ACCESSORS
    attr_reader :path

    def name
      File.basename(@path)
    end


    # PUBLIC METHODS
    def diff(file_info)
      return false if file_info == nil
      raise TypeError, "Invalid type, expecting 'DDiff::FileInfo' but '#{file_info.class}' given." unless file_info.class.name == 'DDiff::FileInfo'
      @stat.select {|key, value|
        value != file_info[key]
      }
    end


    # OPERATORS
    def ==(file_info)
      diff = diff(file_info)
      diff && diff.size == 0 && name == file_info.name
    end

    def [](key)
      raise StandardError, "Unknown file stat key '#{key}'" unless @stat.has_key?(key)
      @stat[key]
    end


    # CONVERTERS
    def from_json(json)
      json = JSON.parse(json, :symbolize_names => true) unless json.class.name == 'Hash'
      @path = json[:name]
      @stat = Hash.new
      json[:stat].each { |key, value| @stat[key.to_sym()] = value }
    end

    def to_json(arg = nil)
      {
          :name => @path,
          :stat => @stat
      }.to_json().strip()
    end


  private
    def _save_file_stat()
      stat = File.stat(@path)
      @stat = {
          :size => stat.size,
          :created => stat.ctime.to_s(),
          :modified => stat.mtime.to_s(),
          :accessed => stat.atime.to_s(),
          :mode => stat.mode
      }
    end
  end
end