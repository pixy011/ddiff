require 'tmpdir'
require 'json'

module DDiff
  class Snapshot

    # PUBLIC CLASS METHODS
    class << self
      def persist(tree, file_name)
        raise TypeError, "Invalid type, expecting 'DDiff::Tree' but '#{tree.class.name}' given" unless
            ['DDiff::Tree', 'TreeMock', 'RestoreTreeMock'].include?(tree.class.name)
        File.open(file_name, 'w') {|file| file.puts(tree.to_json())}
      end

      def restore(file)
        tree = Tree.new
        _recurse_snapshot(JSON.parse(File.read(file), :symbolize_names => true)) { |file| tree.add(FileInfo.new(file)) }
        tree
      end

    private
      def _recurse_snapshot(snapshot, &block)
        snapshot.each_value do |folder|
          folder[:files].each_value { |file| yield file }
          _recurse_snapshot(folder[:children], &block)
        end
      end
    end
  end
end