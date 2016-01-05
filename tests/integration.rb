require 'test/unit'
require '../lib/snapshot'
require '../lib/tree'
require '../lib/file_system'
require '../lib/file_info'

class Integration < Test::Unit::TestCase
  def test_snapshot
    tree = DDiff::Tree.new
    file_system = DDiff::FileSystem.create()
    file_system.recurse('./test') do |entry|
      tree.add(DDiff::FileInfo.new(entry))
    end

    assert_equal '{"":{"children":{},"files":{}},".":{"children":{"test":{"children":{"dir":{"children":{},"files":{"text.txt":{"name":"./test/dir/text.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"test.txt":{"name":"./test/test.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{}}}',
                 tree.to_json()
  end
end