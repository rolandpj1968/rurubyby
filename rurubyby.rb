require 'optparse'

require_relative 'lib/rurubyby/vm/vm'

options = {
  verbose: false,
  scripts: [],
}

puts "ARGV:"
puts ARGV

OptionParser.new do |opts|
  opts.banner = "Usage: rurubyby.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-e SCRIPT", "", "Run a script") do |v|
    options[:scripts] << v
  end
end.order!

puts "ARGV:"
puts ARGV

options[:argv] = ARGV

Rurubyby::Vm::Vm.new(options).run
