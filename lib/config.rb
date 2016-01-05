require 'singleton'

module DDiff
  class Config
    include Singleton

    def initialize()
      @config = {
          :action => 'compare', # snapshot, compare
          :root => './',
          :snapshot_in => './snapshot_in.json',
          :snapshot_out => './snapshot.json',
          :diff_out => './diff.json',
          :whitelist_file => nil,
          :ignore => [],

          #Internal
          :source_type => 'recurse', # recurse, whitelist
          :paths => ['./'],
      }
    end

    def dump
      puts @config.inspect
    end

    def method_missing(key, *value)
      updating = key[-1] == '='
      key = (updating ? key[0..-2] : key).to_sym()
      raise StandardError, "Unknown configuration key '#{key}'" unless @config.has_key?(key)
      if updating
        @config[key] = value[0]
      else
        @config[key]
      end
    end
  end
end