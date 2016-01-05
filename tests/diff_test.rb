require 'test/unit'
require '../lib/diff'
require '../lib/diff_simple'
require '../lib/tree'
require '../lib/file_info'

class FileChangedTreeAMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{"test":{"children":{"dir":{"children":{},"files":{"text.txt":{"name":"./tests/test/dir/text.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"test.txt":{"name":"./tests/test/test.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"file_system_test.rb":{"name":"./tests/file_system_test.rb","stat":{"size":324,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"snapshot_test.rb":{"name":"./tests/snapshot_test.rb","stat":{"size":139,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_info_test.rb":{"name":"./tests/file_info_test.rb","stat":{"size":6339,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree_test.rb":{"name":"./tests/tree_test.rb","stat":{"size":5556,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":85,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"all.rb":{"name":"./tests/all.rb","stat":{"size":57,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":629,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}}'
  end
end

class FileChangedTreeBMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{"test":{"children":{"dir":{"children":{},"files":{"text.txt":{"name":"./tests/test/dir/text.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"test.txt":{"name":"./tests/test/test.txt","stat":{"size":11,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"file_system_test.rb":{"name":"./tests/file_system_test.rb","stat":{"size":324,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"snapshot_test.rb":{"name":"./tests/snapshot_test.rb","stat":{"size":139,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_info_test.rb":{"name":"./tests/file_info_test.rb","stat":{"size":6339,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree_test.rb":{"name":"./tests/tree_test.rb","stat":{"size":5556,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":85,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"all.rb":{"name":"./tests/all.rb","stat":{"size":57,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":329,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}}'
  end
end

class FileCreatedTreeAMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"created.txt":{"name":"./created.txt","stat":{"size":35,"created":"2015-12-30 09:52:46 -0500","modified":"2015-12-30 09:52:46 -0500","accessed":"2015-12-30 09:52:46 -0500","mode":33188}}}}}'
  end
end


class FileCreatedTreeBMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{}}}'
  end
end

class FileDeletedTreeAMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{}}}'
  end
end

class FileDeletedTreeBMock
  def self.json
    '{"":{"children":{},"files":{}},".":{"children":{"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"tree.rb":{"name":"./lib/tree.rb","stat":{"size":1769,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":673,"created":"2015-12-29 15:55:51 -0500","modified":"2015-12-29 15:55:51 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system.rb":{"name":"./lib/file_system.rb","stat":{"size":189,"created":"2015-12-29 16:15:43 -0500","modified":"2015-12-29 16:15:43 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"diff.rb":{"name":"./lib/diff.rb","stat":{"size":793,"created":"2015-12-29 16:15:51 -0500","modified":"2015-12-29 16:15:51 -0500","accessed":"2015-12-29 16:15:55 -0500","mode":33188}},"snapshot.rb":{"name":"./lib/snapshot.rb","stat":{"size":815,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"to_delete.txt":{"name":"./to_delete.txt","stat":{"size":35,"created":"2015-12-30 09:52:46 -0500","modified":"2015-12-30 09:52:46 -0500","accessed":"2015-12-30 09:52:46 -0500","mode":33188}}}}}'
  end
end

class DiffTreeABMock
  def self.json
    '{"a":{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{},"files":{"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":13415,"created":"2015-12-30 11:08:43 -0500","modified":"2015-12-30 11:08:43 -0500","accessed":"2015-12-30 11:08:43 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":654,"created":"2015-12-30 09:21:05 -0500","modified":"2015-12-30 09:21:05 -0500","accessed":"2015-12-30 09:21:05 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}}}}},"files":{"diff.json":{"name":"./diff.json","stat":{"size":2042,"created":"2015-12-30 11:13:02 -0500","modified":"2015-12-30 11:13:02 -0500","accessed":"2015-12-30 11:13:02 -0500","mode":33188}},"snapshot_in.json":{"name":"./snapshot_in.json","stat":{"size":4107,"created":"2015-12-30 09:20:23 -0500","modified":"2015-12-30 09:19:59 -0500","accessed":"2015-12-30 09:20:54 -0500","mode":33188}},"created.txt":{"name":"./created.txt","stat":{"size":35,"created":"2015-12-30 09:52:46 -0500","modified":"2015-12-30 09:52:46 -0500","accessed":"2015-12-30 09:52:46 -0500","mode":33188}}}}},"b":{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{},"files":{"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":829,"created":"2015-12-30 08:26:00 -0500","modified":"2015-12-30 08:26:00 -0500","accessed":"2015-12-30 08:26:00 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":655,"created":"2015-12-30 09:19:51 -0500","modified":"2015-12-30 09:19:51 -0500","accessed":"2015-12-30 09:19:59 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"diff.json":{"name":"./diff.json","stat":{"size":1748,"created":"2015-12-29 17:19:18 -0500","modified":"2015-12-29 17:19:18 -0500","accessed":"2015-12-29 17:19:19 -0500","mode":33188}},"snapshot_in.json":{"name":"./snapshot_in.json","stat":{"size":3504,"created":"2015-12-29 16:49:32 -0500","modified":"2015-12-29 16:27:41 -0500","accessed":"2015-12-29 16:49:38 -0500","mode":33188}}}}}}'
  end
end

class TestDiff < Test::Unit::TestCase
  def teardown
    File.delete('tmp/diffpersist_test.json') if File.exist?('tmp/diffpersist_test.json')
  end


  def test_create_file_changed
    assert_equal 'DDiff::DiffSimple', DDiff::Diff.create(FileChangedTreeAMock.new, FileChangedTreeBMock.new).class.name
    assert_equal 'DDiff::DiffSimple', DDiff::Diff.create(FileChangedTreeAMock.new, FileChangedTreeBMock.new, 'simple').class.name
    assert_equal '{"a":{"":{"children":{},"files":{}},".":{"children":{},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":629,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}},"b":{"":{"children":{},"files":{}},".":{"children":{},"files":{"ddiff.rb":{"name":"./ddiff.rb","stat":{"size":329,"created":"2015-12-29 15:53:48 -0500","modified":"2015-12-29 15:53:48 -0500","accessed":"2015-12-29 15:55:56 -0500","mode":33188}}}}}}',
                 DDiff::Diff.create(_restore(FileChangedTreeAMock.json), _restore(FileChangedTreeBMock.json)).do().to_json()
  end

  def test_persist
    DDiff::Diff.persist(JSON.parse(DiffTreeABMock.json, :symbolize_names => true), 'tmp/diffpersist_test.json')
    json = JSON.parse(File.read('tmp/diffpersist_test.json'), :symbolize_names => true)

    assert_true json.has_key?(:compare_date)
    assert_true json.has_key?(:trees)
    assert_true json[:trees].has_key?(:a)
    assert_true json[:trees].has_key?(:b)
    assert_equal '{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{},"files":{"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":13415,"created":"2015-12-30 11:08:43 -0500","modified":"2015-12-30 11:08:43 -0500","accessed":"2015-12-30 11:08:43 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":654,"created":"2015-12-30 09:21:05 -0500","modified":"2015-12-30 09:21:05 -0500","accessed":"2015-12-30 09:21:05 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-30 11:17:25 -0500","mode":33188}}}}},"files":{"diff.json":{"name":"./diff.json","stat":{"size":2042,"created":"2015-12-30 11:13:02 -0500","modified":"2015-12-30 11:13:02 -0500","accessed":"2015-12-30 11:13:02 -0500","mode":33188}},"snapshot_in.json":{"name":"./snapshot_in.json","stat":{"size":4107,"created":"2015-12-30 09:20:23 -0500","modified":"2015-12-30 09:19:59 -0500","accessed":"2015-12-30 09:20:54 -0500","mode":33188}},"created.txt":{"name":"./created.txt","stat":{"size":35,"created":"2015-12-30 09:52:46 -0500","modified":"2015-12-30 09:52:46 -0500","accessed":"2015-12-30 09:52:46 -0500","mode":33188}}}}}',
                 json[:trees][:a].to_json()
    assert_equal '{"":{"children":{},"files":{}},".":{"children":{"tests":{"children":{},"files":{"diff_test.rb":{"name":"./tests/diff_test.rb","stat":{"size":829,"created":"2015-12-30 08:26:00 -0500","modified":"2015-12-30 08:26:00 -0500","accessed":"2015-12-30 08:26:00 -0500","mode":33188}}}},"lib":{"children":{},"files":{"file_info.rb":{"name":"./lib/file_info.rb","stat":{"size":1771,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"config.rb":{"name":"./lib/config.rb","stat":{"size":655,"created":"2015-12-30 09:19:51 -0500","modified":"2015-12-30 09:19:51 -0500","accessed":"2015-12-30 09:19:59 -0500","mode":33188}},"diff_simple.rb":{"name":"./lib/diff_simple.rb","stat":{"size":552,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}},"file_system_unix.rb":{"name":"./lib/file_system_unix.rb","stat":{"size":577,"created":"2015-12-29 10:08:21 -0500","modified":"2015-12-29 10:08:21 -0500","accessed":"2015-12-29 10:08:28 -0500","mode":33188}}}}},"files":{"diff.json":{"name":"./diff.json","stat":{"size":1748,"created":"2015-12-29 17:19:18 -0500","modified":"2015-12-29 17:19:18 -0500","accessed":"2015-12-29 17:19:19 -0500","mode":33188}},"snapshot_in.json":{"name":"./snapshot_in.json","stat":{"size":3504,"created":"2015-12-29 16:49:32 -0500","modified":"2015-12-29 16:27:41 -0500","accessed":"2015-12-29 16:49:38 -0500","mode":33188}}}}}',
                 json[:trees][:b].to_json()
  end

  private
  def _restore(json)
    tree = DDiff::Tree.new
    _recurse_snapshot(JSON.parse(json, :symbolize_names => true)) { |file| tree.add(DDiff::FileInfo.new(file)) }
    tree
  end

  def _recurse_snapshot(snapshot, &block)
    snapshot.each_value do |folder|
      folder[:files].each_value { |file| yield file }
      _recurse_snapshot(folder[:children], &block)
    end
  end
end