require 'test/unit'
require '../lib/file_info'
require 'date'

class FileStatMock
  def initialize()
    @props = {
        :size => 1000,
        :ctime => DateTime.new(2001,2,3,4,5,6,'+7'),
        :mtime => DateTime.new(2001,2,3,4,5,6,'+7'),
        :atime => DateTime.new(2001,2,3,4,5,6,'+7'),
        :mode => 0644
    }
  end

  def method_missing(name, *value)
    raise "'#{name}' is not found" unless @props.has_key?(name)
    @props[name]
  end
end

class File
  class << self
    alias original_stat stat
    def mock_stat(dummy)
      FileStatMock.new
    end
  end
end

class TestFileInfo < Test::Unit::TestCase
  def setup
    File.class_eval do
      class << self
        alias stat mock_stat
      end
    end
  end

  def teardown
    File.class_eval do
      class << self
        alias stat original_stat
      end
    end
  end

  def test_from_file_path
    file = DDiff::FileInfo.new('/dummy/file')

    assert_equal '/dummy/file', file.path, 'path is /dummy/file'
    assert_equal 1000, file[:size], 'size is 1000'
    assert_equal '2001-02-03T04:05:06+07:00', file[:created], 'created is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:modified], 'modified is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:accessed], 'accessed is 2001-02-03T04:05:06+07:00'
    assert_equal 0644, file[:mode], 'mode is 0644'
  end

  def test_from_hash
    file = DDiff::FileInfo.new({
                                   :name => '/dummy/file',
                                   :stat => {
                                     :size => 1000,
                                     :created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,
                                     :modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,
                                     :accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,
                                     :mode => 0644
                                   }
                               })

    assert_equal '/dummy/file', file.path, 'path is /dummy/file'
    assert_equal 1000, file[:size], 'size is 1000'
    assert_equal '2001-02-03T04:05:06+07:00', file[:created], 'created is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:modified], 'modified is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:accessed], 'accessed is 2001-02-03T04:05:06+07:00'
    assert_equal 0644, file[:mode], 'mode is 0644'
  end

  def test_from_json
    file = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    assert_equal '/dummy/file', file.path, 'path is /dummy/file'
    assert_equal 1000, file[:size], 'size is 1000'
    assert_equal '2001-02-03T04:05:06+07:00', file[:created], 'created is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:modified], 'modified is 2001-02-03T04:05:06+07:00'
    assert_equal '2001-02-03T04:05:06+07:00', file[:accessed], 'accessed is 2001-02-03T04:05:06+07:00'
    assert_equal 0644, file[:mode], 'mode is 0644'
  end

  def test_equality
    file1_1 = DDiff::FileInfo.new('{"name":"/dummy/file1","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')
    file1_2 = DDiff::FileInfo.new('{"name":"/dummy/file2","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    file2_1 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')
    file2_2 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    file3_1 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')
    file3_2 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1005,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    assert_false file1_1 == file1_2, 'FileInfo with different file names are not equal'
    assert_true file2_1 == file2_2, 'FileInfo with same path and stat are equal'
    assert_false file3_1 == file3_2, 'FileInfo with different stat are different'
  end

  def test_compute_diff
    file1_1 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')
    file1_2 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    file2_1 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')
    file2_2 = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1005,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    assert_equal Hash.new, file1_1.diff(file1_2), 'FileInfo#diff with same stat produce empty hash'
    assert_equal ({:size => 1000}), file2_1.diff(file2_2), 'FileInfo#diff with different stat produce an hash with the properties that are different from the other FileInfo'
  end


  def test_to_json
    file = DDiff::FileInfo.new('{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}')

    assert_equal '{"name":"/dummy/file","stat":{"size":1000,"created":"2001-02-03T04:05:06+07:00","modified":"2001-02-03T04:05:06+07:00","accessed":"2001-02-03T04:05:06+07:00","mode":420}}',
        file.to_json(), 'produce valid JSON'
  end

end