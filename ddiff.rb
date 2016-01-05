Dir['./lib/*.rb'].each {|rblib| require rblib }
require 'optparse'

begin
  OptionParser.new do |options|
    options.banner = "DDiff allows to take snapshot of files metadata such as size, mode, times, etc. and compare them to identify files that were modified.\nWritten by Roxanne Courchesne\nUsage: ddiff.rb [options]\nArguments (* denotes default option):"

    options.on('--action ACTION', 'Possible actions: snapshot*, compare') do |action|
      raise ArgumentError, 'Option --action can only accept snapshot or compare as possible actions' unless ['snapshot', 'compare'].include?(action)
      DDiff::Config.instance.action = action
    end

    options.on('--root PATH', 'Select a directory to snapshot/compare. Compare should only be done on snapshots taken from the same directory') do |path|
      DDiff::Config.instance.root = path
    end

    options.on('--snapshot-in PATH', 'Snapshot to compare to') do |path|
      raise ArgumentError, 'File passed to --snapshot-in does not exist' unless File.exist?(path)
      DDiff::Config.instance.snapshot_in = path
    end

    options.on('--snapshot-out PATH', 'Where to save the snapshot') do |path|
      DDiff::Config.instance.snapshot_out = path
    end

    options.on('--diff-out PATH', 'Where to save the diff report') do |path|
      DDiff::Config.instance.diff_out = path
    end

    options.on('-h', '--help', 'Prints this help') do
      puts options
    end
  end.parse!
rescue ArgumentError => e
  puts 'Invalid arguments:'
  puts e.message
  exit 1
end

def snapshot
  tree = DDiff::Tree.new
  file_system = DDiff::FileSystem.create()
  file_system.recurse do |entry|
    tree.add(DDiff::FileInfo.new(entry))
  end

  tree
end

def compare(tree_a)
  tree_b = DDiff::Snapshot.restore(DDiff::Config.instance.snapshot_in)
  diff = DDiff::Diff.create(tree_a, tree_b)
  diff_trees = diff.do()
  DDiff::Diff.persist(diff_trees, DDiff::Config.instance.diff_out)
end

case DDiff::Config.instance.action
  when 'snapshot'
    puts 'patate'
    DDiff::Snapshot.persist(snapshot(), DDiff::Config.instance.snapshot_out)
  when 'compare'
    compare(snapshot())
end