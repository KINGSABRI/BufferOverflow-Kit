#!/usr/bin/env ruby  
#
# Small script to convert opcode to little endian format, like ex. from \x41\x42\x43\x44 or 0x41424344 to \x44\x43\x42\x41
# usage: 
# ruby hex2lendian.rb \x41\x42\x43\x44
# Coded by: KING SABRI
# 

begin 
  
  str		= ARGV[0]
  endian_ar	= []
  endian_final	= ''

  # Sanitization
  def sanitize (string)

    case 
      when string.include?('0x') #== false
	then
	string.gsub(/0x/, "")		# Sanitize "0x77d6b141" format 
      when string.include?("x") 
	then 
	string.gsub(/x/, "")
      end

  end

  str_sanitized		= sanitize(str)
  str_sanitized_ar	= str_sanitized.scan(/.{2}/)

  # Convert string to little endian characters 
  str_sanitized_ar.reverse.each do |bit|
    endian_ar << bit
  end

  # Add \x to be ready for shellcode
  endian_ar.each do |bit|
    endian_final << '\x' + bit
  end

  decoration = "\n" + ("-" * endian_final.length) + "\n"

  puts "[+] little endian characters:" + decoration + endian_final + decoration

rescue
   puts "[!] " + "Error!\n" + "Usage:\n" +
       'ruby hex2lendian.rb \x41\x42\x43\x44' + "\n" +
       "ruby hex2lendian.rb 0x41424344\n\n"
end


