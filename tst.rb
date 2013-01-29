
@shellcode = ARGV

def sanitize (string)
	#if string.include?("x") 
	#	string.gsub(/x/, '\x')		# Sanitize "xdbxc1xbex8e" format to "\xdb\xc1\xbe\x8e"
	if string.include?("\\x") 
		string.gsub("\\x", '\x')
	end
end



def to_bin(file = "file.bin")
	puts "--before-----------------------"
	p @shellcode[0]
	@shellcode = sanitize(@shellcode[0])
	
	puts '\n--after------------------------'
	p @shellcode

	File.open(file , 'wb') do |f|
		f.print  @shellcode
		sleep 0.1
	end
	puts " File name: " + "#{file}"
	puts " File size: " + "#{File.size(file)}" + " bytes."
	puts "Shellcode length  " + "#{@shellcode.size}"
	puts " Done" + "!"
end
    

to_bin
