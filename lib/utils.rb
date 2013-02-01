=begin
https://github.com/cldwalker/hirb/blob/master/lib/hirb/util.rb#L61-71
=end


class BofKUtils


  class Decoration

	attr_reader :terminal_size , :mark

	def terminal_size
	  `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
	rescue
	  puts "I can't detect you commandline environment! - plz contact rise issue: https://github.com/KINGSABRI/BufferOverflow-Kit"
	end

	def decorate(title = "")

	  if title.size + 7 > terminal_size[0]
		puts "Terminal Size is too small, plz resize your terminal's window!" +
				 "plz contact rise issue: https://github.com/KINGSABRI/BufferOverflow-Kit"
		exit
	  end
	  twidth 	 = terminal_size[0]
	  title_head = "---[ "
	  title_tail = " ]"
	  title_tail << "-" * (twidth - title_head.size - title.size - title_tail.size)
	  tail       = "-" * twidth

	  decor = {:head => title_head , :title => title , :tail => title_tail , :end => tail}

	  return decor
	end

	def mark
	  mark = { :+ => "[+] ".green , :- => "[-] " , :! => "[!] ".yellow }
	end

  end


end


