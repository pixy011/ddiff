module DDiff
  class DiffSimple
    def initialize(tree_a, tree_b)
      @tree_a = tree_a
      @tree_b = tree_b
    end

    # PUBLIC METHODS
    def do()
      diff_tree_a = Tree.new
      diff_tree_b = Tree.new
      @tree_a.visit do |file_info_a|
        file_info_b = @tree_b[file_info_a.path]
        if file_info_a != file_info_b
          diff_tree_a.add(file_info_a) unless file_info_a == nil
          diff_tree_b.add(file_info_b) unless file_info_b == nil
        end
      end

      {:a => diff_tree_a, :b => diff_tree_b}
    end
  end
end