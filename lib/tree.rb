require 'json'

module DDiff
  class Tree
    def initialize()
      @tree = Hash.new
      @tree[''.to_sym()] = _create_node()
    end


    # PUBLIC METHODS
    def add(file_info)
      #raise TypeError, "Invalid type, expecting 'DDiff::FileInfo' but '#{file_info.class} given'" unless file_info.class.name == 'DDiff::FileInfo'
      _add_file_info(file_info)
    end

    def visit(node = nil, &block)
      raise ArgumentError, 'Missing block' unless block_given?

      node = @tree if node == nil
      node.each_value do |directory|
        directory[:files].each_value {|file| yield file}
        visit(directory[:children], &block)
      end
    end

    # OPERATORS
    def [](path)
      node = @tree
      parts = path.split(File::SEPARATOR)
      parts.slice(0..-3).each do |part|
        part = part.to_sym()
        return nil unless node.include?(part)
        node = node[part][:children]
      end
      return nil unless node[parts[-2].to_sym()][:files].include?(parts[-1])
      node[parts[-2].to_sym()][:files][parts[-1]]
    end


    # CONVERTERS
    def to_json(dummy = nil)
      @tree.to_json()
    end


  private
    def _create_node()
      {
          :children => Hash.new,
          :files => Hash.new
      }
    end

    def _add_file_info(file_info)
      it = @tree
      parts = File.dirname(file_info.path).split(File::SEPARATOR)
      if !parts.empty?
        parts.each_with_index do |part, index|
          part_sym = part.to_sym()
          it[part_sym] = _create_node() unless it.has_key?(part_sym)
          it = index == parts.size - 1 ?
                it[part_sym] :
                it[part_sym][:children]
        end
      else
        it = @tree.first[1]
      end

      it[:files][file_info.name] = file_info
    end
  end
end