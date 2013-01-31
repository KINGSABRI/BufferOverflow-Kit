#!/usr/bin/env ruby
=begin
pattern create
pattern offset
endian little character converter
hex2bin
bin2hex
=end

APP_ROOT	= Dir.pwd
ROOT		= $:.unshift(File.join(APP_ROOT, "lib"))
BIN		= "#{APP_ROOT}/bin"
OUT		= "#{APP_ROOT}/out"


require	'pry'
require	'pattern'
require	'hex2lendian'
require 'hex2bin'
require 'bin2hex'
require 'optparse'
require 'pp'


options = {}


optparse = OptionParser.new do|opts|
  #--> Pattern create
  opts.on('-c' , '--pattern-create LENGTH', "Create Unique pattern string") do |c|
    options[:create] = c
  end
  #--> Pattern offset
   opts.on('-o', '--pattern-offset OFFSET', "Find Pattern offset string.") do |o|
     options[:offset] = o
   end
  #--> Hex to little endian characters converter
  opts.on('-e', '--hex2lend OPCODE', "Convert Hex to little endian characters.") do |h2le|
    options[:hex2endl] = h2le
  end
  #--> Hex to bin
  opts.on('-b', '--hex2bin ', "Convert Hex shellcode to binary file.") do |h2b|
    options[:hex2bin] = h2b
  end
  #--> bin to Hex
  opts.on('-x', '--bin2hex BINARY_FILE', "Convert binary shellcode to Hex string.") do |bin2hex|
    options[:bin2hex] = bin2hex
  end
  #--> Display the help screen
  opts.banner = "Usage:\n" + 
		"ruby bofk-cli.rb --pattern-create 500\n" 		+
		"ruby bofk-cli.rb --pattern-offset Aa4Z\n" 		+
		"ruby bofk-cli.rb --hex2endl 0x41F2E377\n"		+
		"ruby bofk-cli.rb --hex2bin input.txt output.bin\n" 	+
		"ruby bofk-cli.rb --bin2hex input.bin output.txt\n\n"

  opts.on( '-h', '--help', "Display this screen \n" ) do	
    puts opts
    exit
  end
end
optparse.parse! #(ARGV)
options
ARGV


@pattern  = Pattern.new
@hex2bin  = Hex2Bin.new()
@bin2hex  = Bin2Hex.new

case

#--> Pattern create 
when options[:create]
  then
    puts @pattern.create(options[:create])

#--> Pattern offset
when options[:offset]
  then
    puts @pattern.offset(options[:offset])	  # TODO:  make offset can take 2 ARGS

#--> Hex to little endian characters converter
when options[:hex2endl]
  then
    @hex2lendian = Hex2littleEndian.new(options[:hex2endl])
    puts @hex2lendian.to_Lendian

#--> Hex to bin
when options[:hex2bin]
  then
   p options[:hex2bin]
   @hex2bin.shellcode(options[:hex2bin])
   @hex2bin.to_bin

#--> bin to Hex
when options[:bin2hex]
  then
  puts "\n\n"
  @bin2hex.read(options[:bin2hex])
  puts @bin2hex.to_hex
  puts "\n\n"
else
  puts "WTF!!!"
end



















