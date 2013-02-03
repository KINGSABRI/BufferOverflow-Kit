#!/usr/bin/env ruby
#
# This script is part from Buffer Overflow Kit script
# https://github.com/KINGSABRI/BufferOverflow-Kit
#

APP_ROOT	= Dir.pwd

require "#{APP_ROOT}/gems/colorize-0.5.8/lib/colorize"
require "#{APP_ROOT}/lib/utils"

# Utils
decoration = BofKUtils::Decoration.new
mark       = decoration.mark
decor = decoration.decorate("Hex 2 Bin converter")

shellcode = "" # Puts your shellcode hex here


begin
  file = ARGV[0]

  File.open(file , 'wb') do |f|
    f.print  shellcode
    sleep 0.2
  end
  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
  puts mark[:+] + "File name:".white.underline + " #{file}"
  puts mark[:+] + "Shellcode length:".white.underline + " #{File.size(file)} bytes."
  puts "#{decor[:end]}".light_blue
  puts ""
rescue #Exception => e
  puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue
  puts mark[:!] + "Error!\n" + "Usage:\n"
  puts "Put your shellcode hexs in shellcode variable (Hardcode). then exectue.\n"
  puts "ruby hex2bin.rb [output.bin]"
  puts "#{decor[:end]}".light_blue
  puts ""
end