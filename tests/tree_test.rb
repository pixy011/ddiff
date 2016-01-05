require 'test/unit'
require '../lib/tree'
require 'date'

class FileInfoMock
  def initialize(path, stat)
    @path = path
    @name = File.basename(path)
    @stat = stat
  end

  attr_reader :name, :stat, :path

  def ==(file_info)
    @name == file_info.name && @stat == file_info.stat
  end

  def to_json(arg)
    {:name => @path, :stat => @stat}.to_json().strip()
  end
end

module FakeFileSystem
  def self.files
   @files
  end

  @files = [
      FileInfoMock.new('/file.txt', {:size => 1000,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/image.jpg', {:size => 1001,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/folder/file.txt', {:size => 1002,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/folder/image.jpg', {:size => 1003,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/etc/hostname', {:size => 1004,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/etc/host.conf', {:size => 1005,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/etc/apt/sources.list', {:size => 1006,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/home/roxy/document.doc', {:size => 1007,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644}),
      FileInfoMock.new('/home/roxy/Pictures/image.jpg', {:size => 1008,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644})
  ]
end

class TestTree < Test::Unit::TestCase
  def setup
    @tree = DDiff::Tree.new
    FakeFileSystem::files.each {|file_info|
      @tree.add(file_info)
    }
  end

  def teardown
    @tree = nil
  end

  def test_get_node
    expect = FileInfoMock.new('/home/roxy/Pictures/image.jpg', {:size => 1008,:created => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:modified => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:accessed => DateTime.new(2001,2,3,4,5,6,'+7').to_s,:mode => 0644})

    assert_equal expect, @tree['/home/roxy/Pictures/image.jpg'], 'returned the correct node'
  end

  def test_to_json
    expect = "{\"\":{\"children\":{\"folder\":{\"children\":{},\"files\":{\"file.txt\":{\"name\":\"/folder/file.txt\",\"stat\":{\"size\":1002,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}},\"image.jpg\":{\"name\":\"/folder/image.jpg\",\"stat\":{\"size\":1003,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}},\"etc\":{\"children\":{\"apt\":{\"children\":{},\"files\":{\"sources.list\":{\"name\":\"/etc/apt/sources.list\",\"stat\":{\"size\":1006,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}}},\"files\":{\"hostname\":{\"name\":\"/etc/hostname\",\"stat\":{\"size\":1004,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}},\"host.conf\":{\"name\":\"/etc/host.conf\",\"stat\":{\"size\":1005,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}},\"home\":{\"children\":{\"roxy\":{\"children\":{\"Pictures\":{\"children\":{},\"files\":{\"image.jpg\":{\"name\":\"/home/roxy/Pictures/image.jpg\",\"stat\":{\"size\":1008,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}}},\"files\":{\"document.doc\":{\"name\":\"/home/roxy/document.doc\",\"stat\":{\"size\":1007,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}}},\"files\":{}}},\"files\":{\"file.txt\":{\"name\":\"/file.txt\",\"stat\":{\"size\":1000,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}},\"image.jpg\":{\"name\":\"/image.jpg\",\"stat\":{\"size\":1001,\"created\":\"2001-02-03T04:05:06+07:00\",\"modified\":\"2001-02-03T04:05:06+07:00\",\"accessed\":\"2001-02-03T04:05:06+07:00\",\"mode\":420}}}}}"
    assert_equal expect, @tree.to_json()
  end

  def test_visit
    visitedNode = Array.new
    @tree.visit {|node| visitedNode << node}
    assert_equal FakeFileSystem::files, visitedNode, 'all nodes were visited'
  end
end