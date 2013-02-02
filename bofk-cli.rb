#!/usr/bin/env ruby
=begin
Coded By: Sabry Saleh - KING SABRI

https://github.com/KINGSABRI/BufferOverflow-Kit
=end

APP_ROOT	= Dir.pwd
ROOT		= $:.unshift(File.join(APP_ROOT,'lib'))
GEMS		= "#{APP_ROOT}/gems"
BIN			= "#{APP_ROOT}/bin"
OUT			= "#{APP_ROOT}/out"


#require	'pry'
require "#{GEMS}/colorize-0.5.8/lib/colorize"
require	'pattern'
require	'hex2lendian'
require 'hex2bin'
require 'bin2hex'
require 'optparse'
require 'pp'
require 'utils'

# Utils
decoration = BofKUtils::Decoration.new
mark       = decoration.mark

begin
  options = {}
  optparse = OptionParser.new do|opts|
	opts.separator "Help menu:".underline
	#--> Pattern create
	opts.on('-c' , '--pattern-create LENGTH', "Create Unique pattern string.") 		do |c|
	  options[:create] = c
	end
	#--> Pattern offset
	opts.on('-o', '--pattern-offset OFFSET', "Find Pattern offset string.") 		do |o|
	  options[:offset] = o
	end
	#--> Hex to little endian characters converter
	opts.on('-e', '--hex2lend OPCODE', "Convert Hex to little endian characters.") 		do |h2le|
	  options[:hex2endl] = h2le
	end
	#--> Hex to bin
	opts.on('-b', '--hex2bin HEX_STRING', "Convert Hex shellcode to binary file.") 		do |h2b|
	  options[:hex2bin] = h2b
	end
	#--> bin to Hex
	opts.on('-x', '--bin2hex BINARY_FILE', "Convert binary shellcode to Hex string.") 	do |bin2hex|
	  options[:bin2hex] = bin2hex
	end
	#--> Version
	opts.on('-V', '--version', 'Display BufferOver flow Kit version.')			do |v|
	  options[:version] = v
	end
	#--> Help screen
	opts.banner = "\nUsage:".underline 						+
		" ruby bofk-cli.rb {OPTIONS} ARGUMENT\n" 				+
		"\nExamples:\n".underline						+
		"ruby bofk-cli.rb --pattern-create 500\n" 				+
		"ruby bofk-cli.rb --pattern-offset Aa4Z\n" 				+
		"ruby bofk-cli.rb --hex2endl 0x41F2E377\n"				+
		"ruby bofk-cli.rb --hex2bin input.txt output.bin\n" 			+
		"ruby bofk-cli.rb --bin2hex input.bin\n\n"

	opts.on( '-h', '--help', "Display this screen \n" ) 					do
	  decor = decoration.decorate("Help screen")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{opts}"
	  puts "#{decor[:end]}".light_blue
	  exit
	end
  end
  optparse.parse! #(ARGV)
  options
  ARGV

  @pattern  = Pattern.new
  @hex2bin  = Hex2Bin.new
  @bin2hex  = Bin2Hex.new

  case
	#--> Pattern create
	when options[:create]
	then
	  decor = decoration.decorate("Pattern create")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts mark[:+] + "Size: #{@pattern.create(options[:create]).size}\n".white.underline
	  puts "#{@pattern.create(options[:create])}".light_cyan
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Pattern offset
	when options[:offset]
	then
	  decor = decoration.decorate("Pattern offset")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{@pattern.offset(options[:offset])}".light_cyan	  # TODO:  make offset can take 2 ARGS
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Hex to little endian characters converter
	when options[:hex2endl]
	then
	  decor = decoration.decorate("Little endian format")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  @hex2lendian = Hex2littleEndian.new(options[:hex2endl])
	  puts "#{@hex2lendian.to_Lendian}".light_cyan
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Hex to bin
	when options[:hex2bin]
	then
	  decor = decoration.decorate("Hex to Binary")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  #p options[:hex2bin]
	  #@hex2bin.shellcode(options[:hex2bin])
	  #@hex2bin.to_bin
	  puts "This function is not working currently!"
	  puts "#{decor[:end]}".light_blue
	  puts ""
	  exit

	#--> bin to Hex
	when options[:bin2hex]
	then
	  decor = decoration.decorate("Binary to Hex")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  @bin2hex.read(options[:bin2hex])
	  puts mark[:+] + "File Size: #{File.size(options[:bin2hex])} byte.\n".white.underline
	  puts "#{@bin2hex.to_hex}".light_cyan
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Version
	when options[:version]
	  puts "You should include lib/version.rb file"

	else
	  decor = decoration.decorate("Help screen")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{optparse}"
	  puts "#{decor[:end]}".light_blue
  end
rescue
  decor = decoration.decorate("Help screen")
  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
  puts "#{optparse}"
  puts "#{decor[:end]}".light_blue
end




