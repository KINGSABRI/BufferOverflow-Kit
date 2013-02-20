#!/usr/bin/env ruby
=begin
Coded By: Sabry Saleh - KING SABRI

https://github.com/KINGSABRI/BufferOverflow-Kit
=end

APP_ROOT	= Dir.pwd
ROOT		= $:.unshift(File.join(APP_ROOT,'lib'))
GEMS		= "#{APP_ROOT}/gems"
BIN		= "#{APP_ROOT}/bin"
OUT		= "#{APP_ROOT}/out"
VERSION 	= "0.0.5"

require "#{GEMS}/colorize-0.5.8/lib/colorize.rb"
require	'pattern'
require	'hex2lendian'
require 'hex2bin'
require 'bin2hex'
require 'optparse'
require 'pp'
require 'utils'
require 'pry'

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
	#--> Pattern offset: offset string
	opts.on('-o', '--pattern-offset OFFSET', "Find Pattern offset string.") 		do |o|
	  options[:offset] = o
	end
	#--> Pattern offset: pattern length
	opts.on('-l', '--pattern-length LENGTH', "Only used with 'pattern-offset' if pattern was longer than 20280.") 		do |l|
	  options[:pattern_length] = l
	end
	#--> Hex to little endian characters converter
	opts.on('-e', '--hex2lend OPCODE', "Convert Hex to little endian characters.") 		do |h2le|
	  options[:hex2endl] = h2le
	end
	#--> Hex to bin
	#opts.on('-b', '--hex2bin HEX_STRING', "Convert Hex shellcode to binary file.") 		do |h2b|
	#  options[:hex2bin] = h2b
	#end
	#--> bin to Hex
	opts.on('-x', '--bin2hex BINARY_FILE', "Convert binary shellcode to Hex string.") 	do |bin2hex|
	  options[:bin2hex] = bin2hex
	end
	#--> bin to Hex: Format type
	opts.on('-t', '--type TYPE', "Only used with 'bin2hex'. Types: ruby, perl, python, c.") 	do |type|
	  options[:type] = type
	end
	#--> Version
	opts.on('-v', '--version', 'Display Buffer Overflow Kit version.')			do |v|
	  options[:version] = v
	end
	#--> Help screen
	opts.banner = "\nUsage:".underline 						+
		" ruby bofk-cli.rb {OPTIONS} ARGUMENT\n\n"

	opts.on( '-h', '--help', "Display help screen \n" ) 					do
	  decor = decoration.decorate("Help screen.")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{opts}"

	  puts "\nExternal tools - bin/\n".underline		+
			   "[-] hex2bin.rb \t Hex to Binary file - BoFkit.\n"		+
			   "[-] nasm.exe \t Assembler and disassembler.\n"		+
			   "[-] mona.py \t Immunity debugger plugin - Corelan team.\n"

	  puts "\nExamples:\n".underline						+
			   "ruby bofk-cli.rb --pattern-create 500\n" 			+
			   "ruby bofk-cli.rb --pattern-offset Aa4Z\n" 			+
			   "ruby bofk-cli.rb --pattern-offset Zu2Z --pattern-length 40000\n" 			+
			   "ruby bofk-cli.rb --hex2lend 0x41F2E377\n"			+
			   "ruby bofk-cli.rb --bin2hex input.bin\n\n"
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
	  puts mark[:+] + "Size:".white.underline + " #{@pattern.create(options[:create]).size}\n".white
	  puts "#{@pattern.create(options[:create])}".light_cyan
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Pattern offset
	when options[:offset]
	then
	  offset = @pattern.offset(options[:offset], options[:pattern_length])
	  decor = decoration.decorate("Pattern offset")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts mark[:+] + "Actual pattern length:".white.underline + " #{offset[:length]} chars.".white
	  puts mark[:+] + "Matches:".white.underline + " #{offset[:offset].size} times.\n".white

	  offset[:offset].each {|o| puts "#{o}".light_cyan}

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
	  puts "This function moved to bin/hex2bin.rb as external tool"
	  puts "#{decor[:end]}".light_blue
	  puts ""
	  exit

	#--> bin to Hex
	when options[:bin2hex]
	then
	  decor = decoration.decorate("Binary to Hex")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  @bin2hex.read(options[:bin2hex])
	  puts mark[:+] + "File Size:".white.underline + " #{File.size(options[:bin2hex])} bytes.".white
	  	  if options[:type] == nil
		  type = "No format specified."
	  else
		  type = options[:type]
	  end
	  puts mark[:+] + "Format type:".white.underline + " #{type} \n".white
	  puts "#{@bin2hex.to_hex(options[:type])}".light_cyan
	  puts "#{decor[:end]}".light_blue
	  puts ""

	#--> Version
	when options[:version]
	  decor = decoration.decorate("BoFKit Version")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{VERSION}"
	  puts "#{decor[:end]}".light_blue

	else
	  decor = decoration.decorate("Help screen")
	  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
	  puts "#{optparse}"
	  puts "#{decor[:end]}".light_blue
  end

rescue OptionParser::InvalidOption, OptionParser::MissingArgument, OptionParser::NO_ARGUMENT
  decor = decoration.decorate("Help screen")
  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
  puts "#{optparse}"
  puts "#{decor[:end]}".light_blue
end




