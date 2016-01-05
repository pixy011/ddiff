require 'test/unit'
require 'json'
require '../lib/snapshot'

class TreeMock
  def to_json
    '{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{"test":{"children":{"dir":{"children":{},"files":{"text.txt":{"name":"./tests/test/dir/text.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"test.txt":{"name":"./tests/test/test.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"file_system_test.rb":{"name":"./tests/file_system_test.rb","stat":{"size":324,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"snapshot_test.rb":{"name":"./tests/snapshot_test.rb","stat":{"size":139,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_info_test.rb":{"name":"./tests/file_info_test.rb","stat":{"size":6339,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree_test.rb":{"name":"./tests/tree_test.rb","stat":{"size":5556,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":85,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"all.rb":{"name":"./tests/all.rb","stat":{"size":57,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":629,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}}'
  end
end

class RestoreTreeMock
  def to_json
    '{".":{"children":{},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":629,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}}'
  end
end

class Tree
  def initialize()
    @tree = Hash.new
  end

  def add(file_info)
    @tree[file_info.name] = file_info
  end

  def to_json()
    @tree.to_json().strip()
  end
end

class FileInfo
  def initialize(file)
    @file = file
  end

  def name()
    @file[:name]
  end

  def to_json(arg = nil)
    @file.to_json().strip()
  end
end

class TestSnapshot < Test::Unit::TestCase
  def teardown
    File.delete('tmp/persist_test.json') if File.exist?('tmp/persist_test.json')
    File.delete('tmp/restore_test.json') if File.exist?('tmp/restore_test.json')
  end

  def test_persist
    DDiff::Snapshot.persist(TreeMock.new, 'tmp/persist_test.json')
    assert_equal "{\"\":{\"children\":{},\"files\":{}},\".\":{\"children\":{\"tests\":{\"children\":{\"test\":{\"children\":{\"dir\":{\"children\":{},\"files\":{\"text.txt\":{\"name\":\"./tests/test/dir/text.txt\",\"stat\":{\"size\":11,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}}}}},\"files\":{\"test.txt\":{\"name\":\"./tests/test/test.txt\",\"stat\":{\"size\":11,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}}}}},\"files\":{\"file_system_test.rb\":{\"name\":\"./tests/file_system_test.rb\",\"stat\":{\"size\":324,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"snapshot_test.rb\":{\"name\":\"./tests/snapshot_test.rb\",\"stat\":{\"size\":139,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"file_info_test.rb\":{\"name\":\"./tests/file_info_test.rb\",\"stat\":{\"size\":6339,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"tree_test.rb\":{\"name\":\"./tests/tree_test.rb\",\"stat\":{\"size\":5556,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"diff_test.rb\":{\"name\":\"./tests/diff_test.rb\",\"stat\":{\"size\":85,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"all.rb\":{\"name\":\"./tests/all.rb\",\"stat\":{\"size\":57,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}}}},\"lib\":{\"children\":{},\"files\":{\"file_info.rb\":{\"name\":\"./lib/file_info.rb\",\"stat\":{\"size\":1771,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"tree.rb\":{\"name\":\"./lib/tree.rb\",\"stat\":{\"size\":1769,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"config.rb\":{\"name\":\"./lib/config.rb\",\"stat\":{\"size\":673,\"created\":\"2015-12-29 15:55:51 -0500\",\"modified\":\"2015-12-29 15:55:51 -0500\",\"accessed\":\"2015-12-29 15:55:56 -0500\",\"mode\":33188}},\"diff_simple.rb\":{\"name\":\"./lib/diff_simple.rb\",\"stat\":{\"size\":552,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"file_system.rb\":{\"name\":\"./lib/file_system.rb\",\"stat\":{\"size\":189,\"created\":\"2015-12-29 16:15:43 -0500\",\"modified\":\"2015-12-29 16:15:43 -0500\",\"accessed\":\"2015-12-29 16:15:55 -0500\",\"mode\":33188}},\"diff.rb\":{\"name\":\"./lib/diff.rb\",\"stat\":{\"size\":793,\"created\":\"2015-12-29 16:15:51 -0500\",\"modified\":\"2015-12-29 16:15:51 -0500\",\"accessed\":\"2015-12-29 16:15:55 -0500\",\"mode\":33188}},\"snapshot.rb\":{\"name\":\"./lib/snapshot.rb\",\"stat\":{\"size\":815,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}},\"file_system_unix.rb\":{\"name\":\"./lib/file_system_unix.rb\",\"stat\":{\"size\":577,\"created\":\"2015-12-29 10:08:21 -0500\",\"modified\":\"2015-12-29 10:08:21 -0500\",\"accessed\":\"2015-12-29 10:08:28 -0500\",\"mode\":33188}}}}},\"files\":{\"ddiff.rb\":{\"name\":\"./ddiff.rb\",\"stat\":{\"size\":629,\"created\":\"2015-12-29 15:53:48 -0500\",\"modified\":\"2015-12-29 15:53:48 -0500\",\"accessed\":\"2015-12-29 15:55:56 -0500\",\"mode\":33188}}}}}\n",
                 File.read('tmp/persist_test.json')
  end

  def test_restore
    DDiff::Snapshot.persist(RestoreTreeMock.new, 'tmp/restore_test.json')
    tree = DDiff::Snapshot.restore('tmp/restore_test.json')
    assert_equal '{"./ddiff.rb":{"name":"./ddiff.rb","stat":{"size":629,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}',
                 tree.to_json()
  end
end