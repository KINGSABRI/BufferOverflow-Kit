=begin
https://github.com/cldwalker/hirb/blob/master/lib/hirb/util.rb#L61-71
=end


class BofKUtils

	  #class FilesFolders
	  #
		#  #def exist?(file)
		#	#case
		#	#  when File.exist?(file) == true
		#	#	puts true
		#	#  when File.exist? file == false
		#	#	puts "[+] Error!: #{file} : No such file or directory"
		#	#end
		#  #end
	  #
		#  def readable?
	  #
		#  end
	  #
	  #end	# FilesFolders


		class Etc

		    attr_reader :terminal_size

			def terminal_size
				#if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
				  [ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
				#elsif STDIN.tty? && command_exists?('stty')
				  `stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
				#else
				#  nil
				#end
			rescue
			   puts "I can't detect you commandline environment! - plz contact rise issue: https://github.com/KINGSABRI/BufferOverflow-Kit"
			end

			def decorate(title)

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


		end


end
#require '/run/media/KING/ZONE/Programming-Zone/Ruby/Projects/BoF-Kit-dev/gems/colorize-0.5.8/lib/colorize'
#u = BofKUtils::Etc.new
#decor = u.decorate("Pattern create")
#puts "#{decor[:head]}".light_blue + "#{decor[:title]}".white + "#{decor[:tail]}".light_blue