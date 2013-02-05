=begin
https://github.com/cldwalker/hirb/blob/master/lib/hirb/util.rb#L61-71
=end

class BofKUtils


  class FilesFolders

	def initialize
	  @mark = Decoration.new.mark
	end

	def file_exist?(file)
	  case
		when File.directory?(file) == true
		  puts @mark[:!] + "Error!:" + " #{file} : Please mention file not Directory!!"
		  exit
		when File.exist?(file) == true
		  return true
		when File.exist?(file) == false
		  puts @mark[:!] + "Error!:" + " #{file} : File not found!"
		  exit
	  end
	end

  end   # FilesFolders

  class Decoration

	attr_reader :terminal_size , :mark

	def terminal_size
	  `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
	rescue
	  puts "I can't detect you commandline environment! - plz contact rise issue: https://github.com/KINGSABRI/BufferOverflow-Kit"
	end

	def decorate(title = "")

	  if title.size + 7 > terminal_size[0]
		puts "\n\nTerminal Size is too small, plz resize your terminal's window!" +
				 "plz contact rise issue: https://github.com/KINGSABRI/BufferOverflow-Kit\n\n"
		exit
	  end
	  twidth 	 = terminal_size[0]
	  title_head = "---[ "
	  title_tail = " ]"
	  title_tail << "-" * (twidth - title_head.size - title.size - title_tail.size)
	  tail       = "-"  * twidth

	  decor = {:head => title_head , :title => title , :tail => title_tail , :end => tail}

	  return decor
	end

	def mark
	  mark = { :+ => "[+] ".green , :- => "[-] " , :! => "[!] ".yellow }
	end

  end

  class Decode

	# Sanitization
	def sanitize (string)
	  case
		when string.include?('0x') #== false
		  string = string.gsub(/0x/, "")		# Sanitize "0x77d6b141" format
		when string.include?("\\x")
		  string = string.gsub(/[\\x]/, "")		# Sanitize "\x77\xd6\xb1\x41" format
		when string.include?('x')
		then
		  string = string.gsub(/[\\x]/, "")		# Sanitize "\x77\xd6\xb1\x41" format
		else
		  return string
	  end
	end

	def to_hex(ascii)
	  ascii.unpack('H*')[0]
	end

	def to_ascii(hex)
	  hex_sanitized = sanitize(hex)
	  [hex_sanitized].pack('H*')
	end
  end
end

