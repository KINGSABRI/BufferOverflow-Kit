#
# Class to write hex shellcode into binary file
#


class Hex2Bin

	def initialize
		decor   = BofKUtils::Decoration.new
		@mark    = decor.mark
	end

    begin

	#
	# Hex Shellcode
	#
        def hex_shellcode
			file = ".shellcode.txt"
			#File.rename("#{file}" , ".shellcode-#{Random.rand(1...100)}.txt") if File.exist?("#{file}")
			File.rename("#{file}" , ".shellcode-#{Time.new.strftime("%Y-%m-%d__%H:%M:%S")}.txt") if File.exist?("#{file}")

			puts @mark[:+] + "Paste your shellcode then press ctrl+x\n"
			sleep 3
			system("nano #{file}")
			if File.exist?("#{file}") == false
				puts @mark[:!] + "You Did not save your file correctly!, please try again and Dont forget to save the file.\n\n".red
				exit
			end
			puts @mark[:+] +  "Hex string has been saved in file name: #{file}\n\n"

			return file
		end


	#
	# Write Shellcode to binary file
	#
        def to_bin(hex_shellcode)
			binary_name = "shellcode"
			file = File.read(hex_shellcode)
			file = file.squeeze("\n").split.join.gsub(/[+|.]/ , "").gsub("\"","").gsub(";","")		# Sanitaize hex format
			`ruby -e 'print "#{file}"' > #{binary_name}`

			binary_size = File.size(binary_name)

			return {:bname => binary_name , :bsize => binary_size}
        end

    rescue
        puts "[!]" + "Error!\n" + "Usage:\n" +
                 "  Put your shellcode hexs in shellcode variable (Hardcode). then exectue.\n" +
                 "ruby hex2bin.rb [output.bin]\n\n"
    end
end


