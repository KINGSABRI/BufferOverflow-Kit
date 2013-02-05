#!/usr/bin/env ruby


class Pattern

  def initialize
	@pattern = []
	@offset  = String
	@decode  = BofKUtils::Decode.new
	udecore  = BofKUtils::Decoration.new
	@mark    = udecore.mark
	@end     = udecore.decorate[:end]
  end


  def create(length)
	length = length.to_i
	if length != 0 or nil
	  @pattern = ('Aa0'..'Zz9').to_a.join.each_char.first(length).join	# default value 702940
	else
	  puts @mark[:!] + "Error!:\n" + "'--pattern-create' accepts INTEGER and > 0 values only!"
	  puts "Usage: ruby bofk-cli.rb --pattern-create [INTEGER_VALUE]"
	  puts "#{@end}".light_blue + "\n\n"
	  length = 0
	  exit
	end

	return @pattern
  end


  def offset(string , length = 100000)
	@pattern = ('Aa0'..'Zz9').to_a.first(length.to_i).join            # default length 175735 * 4
	lendian = ""

	case
	  when @offset  = @pattern.index(string.to_s) != nil
		@offset  = @pattern.index(string.to_s)
		return @offset
	  when @offset  = @pattern.index(string.to_s) == nil
		# Convert string to little endian characters
		string = @decode.sanitize(string)
		string = string.scan(/.{2}/)
		string = string.reverse.each {|bit| lendian << bit }.join		# Reverse little endian
		string   = @decode.to_ascii(string)		# convert it to hex for search
		@offset  = @pattern.index(string.to_s)
		return @offset
	  else
		puts @mark[:!] + "Error!:\n" + "Your 'offset' is wrong or too long, plz mention it!"
		puts "Usage: ruby bofk-cli.rb --pattern-offset [PATTERN] [Pattern_Size]"
		puts "ex. bofk-cli.rb --pattern-offset PAa6 20000"
		puts "#{@end}".light_blue + "\n\n"
		exit
	end

  end

end





