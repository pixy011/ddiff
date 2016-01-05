require 'test/unit'
require '../lib/file_system'

class TestFileSystem < Test::Unit::TestCase
  def test_recurse
    expected = [
        './test/dir/text.txt',
        './test/test.txt'
    ]

    fs = DDiff::FileSystem.create()
    fs.recurse('./test') do |file|
      assert_true expected.include?(file)
    end
  end
end