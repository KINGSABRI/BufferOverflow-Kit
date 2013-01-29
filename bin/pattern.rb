#!/usr/bin/env ruby


class Pattern
  
  def initialize
    
    @pattern = []
    @offset  = String
    
  end
  
  
  def create(length)
    if length != 0 or nil
      #@pattern = ('Aa0A'..'Zz9Z').to_a.first(length)	# default values 175735 * 4
      @pattern = ('Aa0A'..'Zz9Z').to_a.join.each_char.first(length.to_i).join	# default value 702940
    else
      puts "\n[+] Error!: --pattern-create accepts INTEGER and > 0 values only!"
      puts "Usage: --pattern-create [VALUE]\n\n"
      length = 0
    end

    return @pattern
  end
  

  def offset(string , length = 10000)
    @pattern = ('Aa0A'..'Zz9Z').to_a.first(length.to_i).join            # default values 175735 * 4
    @offset = @pattern.index(string.to_s)
    if @offset.nil?
      puts "\n[+] Error!: Your pattern is wrong or too long, plz mention it!"
      puts "Usage: --pattern-offset #{string} Pattern_Size"
      puts "ex. bofk-cli.rb --pattern-offset PAa6 20000\n\n"
#       exit 1
    end

    return @offset
  end
  
end





