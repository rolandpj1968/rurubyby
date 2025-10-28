require 'optparse'

require_relative 'lib/rurubyby/vm'

options = {
  verbose: false,
}

OptionParser.new do |opts|
  opts.banner = "Usage: rurubyby.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-e SCRIPT", "", "Run a script") do |v|
    options[:script] = v
  end
end.parse!

Rurubyby::Vm.new(options).run
