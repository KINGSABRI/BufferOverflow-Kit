

class Pattern

  def initialize
	@pattern = []
	@offset  = String
	udecore  = BofKUtils::Decoration.new
	@mark    = udecore.mark
	@end     = udecore.decorate[:end]
  end


  def create(length)
	length = length.to_i
	if length != 0 or nil
	  #@pattern = ('Aa0A'..'Zz9Z').to_a.first(length)	# default values 175735 * 4
	  @pattern = ('Aa0A'..'Zz9Z').to_a.join.each_char.first(length).join	# default value 702940
	else
	  puts @mark[:!] + "Error!:\n" + "'--pattern-create' accepts INTEGER and > 0 values only!"
	  puts "Usage: ruby bofk-cli.rb --pattern-create [INTEGER_VALUE]"
	  puts "#{@end}".light_blue + "\n\n"
	  length = 0
	  exit
	end

	return @pattern
  end


  def offset(string , length = 10000)
	@pattern = ('Aa0A'..'Zz9Z').to_a.first(length.to_i).join            # default values 175735 * 4
	@offset  = @pattern.index(string.to_s)
	if @offset.nil?
	  puts @mark[:!] + "Error!:\n" + "Your 'offset' is wrong or too long, plz mention it!"
	  puts "Usage: ruby bofk-cli.rb --pattern-offset [PATTERN] [Pattern_Size]"
	  puts "ex. bofk-cli.rb --pattern-offset PAa6 20000"
	  puts "#{@end}".light_blue + "\n\n"
	  exit
	end

	return @offset
  end

end


