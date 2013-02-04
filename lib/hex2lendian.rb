#!/usr/bin/env ruby  
#
# Small script to convert opcode to little endian format, like ex. from \x41\x42\x43\x44 or 0x41424344 to \x44\x43\x42\x41
# usage: 
# ruby hex2lendian.rb \x41\x42\x43\x44
# Coded by: KING SABRI
#

class Hex2littleEndian

  def initialize(string)
	@string		= string
	@endian_ar		= []
	@endian_final	= ''
	udecore  = BofKUtils::Decoration.new
	@mark    = udecore.mark
	@end     = udecore.decorate[:end]
  end

  begin
	# Sanitization
	def sanitize (string)
	  case
		when string.include?('0x') #== false
		  string.gsub(/0x/, "")		# Sanitize "0x77d6b141" format
		when string.include?("x")
		  string.gsub(/[\\x]/, "")		# Sanitize "\x77\xd6\xb1\x41" format
		when string.include?('x')
		  string.gsub(/[\\x]/, "")		# Sanitize "\x77\xd6\xb1\x41" format
	  end
	end

	def to_Lendian
	  str_sanitized	= sanitize(@string)
	  str_sanitized_ar	= str_sanitized.scan(/.{2}/)

	  # Convert string to little endian characters
	  str_sanitized_ar.reverse.each do |bit|
		@endian_ar << bit
	  end

	  # Add \x to be ready for shellcode
	  @endian_ar.each do |bit|
		@endian_final << '\x' + bit
	  end

	  return @endian_final
	end

  rescue
	puts @mark[:!] + "Error!:\n" + "Invalid input"
	puts "Usage: ruby bofk-cli.rb --hex2lend [HEX_STRING]"
	puts "#{@end}".light_blue + "\n\n"
  end
end










