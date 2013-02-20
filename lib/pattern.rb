#!/usr/bin/env ruby


class Pattern
  
  def initialize
    @pattern = []
    @offset  = String
    @decode  = BofKUtils::Decode.new
    udecore  = BofKUtils::Decoration.new
    @mark    = udecore.mark
    @end     = udecore.decorate[:end]
    @type    = udecore
  end
  
  
  def create(length , format = nil)

    length = length.to_i

    if length != 0 or nil

        # Lets to solve if length was > maximum number of permutations which is (20280)
        if length > 20280

          @pattern = ('Aa0'..'Zz9').to_a.join.each_char.first(length).join
          @pattern = @pattern  * (length / 20280.to_f).ceil

        else

                  @pattern = ('Aa0'..'Zz9').to_a.join.each_char.first(length).join

        end

    else
        puts @mark[:!] + "Error!:\n" + "'--pattern-create' accepts INTEGER and > 0 values only!"
        puts "Usage: ruby bofk-cli.rb --pattern-create [INTEGER_VALUE]"
            puts "#{@end}".light_blue + "\n\n"
        length = 0              # Oh, Seriously!?   no just kidding :P
        exit
    end

        # Output format: using option --type
        if format != nil
            formatted = @type.format(@pattern.scan(/.{2}/), format, 50)
            holder    = ""
            formatted.map do |l|
                    if l != formatted.last
                            holder << "\"#{l[0..-2].join}\"" + l.last
                    else
                            holder << "\"#{l[0..-2].join}\"" + l.last
                    end
            end
            @pattern = holder
        end

    return @pattern
  end


  def offset(string , length)
      string = string.to_s
      length = length.to_i
      length = 20280 if length == nil || length == 0
      @pattern = create(length)
      lendian = ""

        # TODO find smarter way to detect the inputs type
      begin
        if length <= 20280
              case
                # if user input was from pattern format     << Wrong : We need to detect offset location here and if it's matching more than once
                when @offset  = @pattern.index(string.to_s) != nil
                      @offset = @pattern.enum_for(:scan , string).map {Regexp.last_match.begin(0)}
                      return {:offset => @offset, :length => @pattern.size}

                # if user input was from memory little endian format
                when @offset  = @pattern.index(string.to_s) == nil
                      # Convert string to little endian characters
                      string = @decode.sanitize(string)
                      string = string.scan(/.{2}/)
                      string = string.reverse.each {|bit| lendian << bit }.join               # Reverse little endian
                      string = @decode.to_ascii(string)               # convert it to hex for search
                      @offset  = @pattern.enum_for(:scan , string).map {Regexp.last_match.begin(0)}  # TODO YOU SHOULD CHECK IF STILL NOT EXIST?

                      if @offset[0] != nil
                        return {:offset => @offset, :length => @pattern.size}
                      else
                        puts @mark[:!] + "Error!:\n" + "Your 'offset' is wrong or longer than 20280, plz mention it!"
                        puts "Usage: ruby bofk-cli.rb --pattern-offset [PATTERN] [Pattern_Size]"
                        puts "ex. bofk-cli.rb --pattern-offset PAa6 -l 50000"
                        puts "#{@end}".light_blue + "\n\n"
                        exit
                      end

              end

        elsif length > 20280
              case
                # if user input was from pattern format     << Wrong : We need to detect offset location here and if it's matching more than once
                when @offset  = @pattern.index(string.to_s) != nil
                      @offset = @pattern.enum_for(:scan , string).map {Regexp.last_match.begin(0)}

                      return {:offset => @offset, :length => @pattern.size}

                # if user input was from memory little endian format
                when @offset  = @pattern.index(string.to_s) == nil
                      # Convert string to little endian characters
                      string = @decode.sanitize(string)
                      string = string.scan(/.{2}/)
                      string = string.reverse.each {|bit| lendian << bit }.join               # Reverse little endian format
                      string = @decode.to_ascii(string)               # convert it to hex for search
                      @offset = @pattern.enum_for(:scan , string).map {Regexp.last_match.begin(0)}

                      if @offset[0] != nil
                        return {:offset => @offset, :length => @pattern.size}
                      else
                        puts @mark[:!] + "Error!:\n" + "Your 'offset' is wrong or longer than 20280, plz mention it!"
                        puts "Usage: ruby bofk-cli.rb --pattern-offset [PATTERN] [Pattern_Size]"
                        puts "ex. bofk-cli.rb --pattern-offset PAa6 -l 50000"
                        puts "#{@end}".light_blue + "\n\n"
                        #exit
                      end

                else
                      puts @mark[:!] + "Error!:\n" + "Your 'offset' is wrong or longer than #{length}, plz mention it!"
                      puts "Usage: ruby bofk-cli.rb --pattern-offset [PATTERN] [Pattern_Size]"
                      puts "ex. bofk-cli.rb --pattern-offset PAa6 30000"
                      puts "#{@end}".light_blue + "\n\n"
                      exit
              end

        end

        rescue  Exception => e
        puts e
      end

  end
  
end



