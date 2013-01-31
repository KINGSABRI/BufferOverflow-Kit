

class Bin2Hex

  def initialize
	@file2read	= ""
	@hex		= ""
  end

  def read(file)
	reader     = File.open("#{file}" , 'rb')
	@file2read = reader.read.each_byte.map { |b| "%02x" % b }   		#  b.to_s(16).rjust(2, '0')

	return @file2read
  end

  def to_hex
  	hex_ary = @file2read.join.scan(/.{2}/)
	hex_ary.map do |byte|
	  @hex << '\x' + byte
	end

	return @hex
  end

end


# TODO add file checker
















