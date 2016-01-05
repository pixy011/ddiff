require 'json'

module DDiff
  class Diff
    class << self

      def create(tree_a, tree_b, method='simple')
        Object::const_get('DDiff::Diff' + method.capitalize()).new(tree_a, tree_b)
      end

      def persist(diff_trees, file_name)
        raise TypeError, 'Invalid type/format, expecting {:a => DDiff::Tree, :b => DDiff::Tree}' unless
              diff_trees.class.name == 'Hash' &&
                (diff_trees.has_key?(:a) && ['DDiff::Tree', 'Hash'].include?(diff_trees[:a].class.name)) &&
                (diff_trees.has_key?(:b) && ['DDiff::Tree', 'Hash'].include?(diff_trees[:b].class.name))

        File.open(file_name, 'w') do |file|
          report = {
              :compare_date => Time.now(),
              :trees => diff_trees
          }
          file.puts(report.to_json())
        end
      end
    end
  end
end