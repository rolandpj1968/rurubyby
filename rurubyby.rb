require 'optparse'
require 'prism'

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

script = options[:script]

if script
  puts "Executing: '#{script}'"

  parse_result = Prism.parse(script)

  puts
  puts "parse_result:"
  puts parse_result.inspect

  ast = parse_result.value
  puts
  puts "AST:"
  puts ast.inspect
else
  puts "No script given"
end
