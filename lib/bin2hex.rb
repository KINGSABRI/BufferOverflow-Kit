
require 'utils'

class Bin2Hex

  def initialize
	@file2read	= ""
	@hex		= []

  end

  def read(file)
	reader     = File.open("#{file}" , 'rb')
	@file2read = reader.read.each_byte.map { |b| "%02x" % b }   		#  b.to_s(16).rjust(2, '0')

	return @file2read	# array
  end


  def to_hex(format)

	hex_ary = @file2read

	# Default without type option
	if format == nil

		  hex_ary.map do |byte|
			@hex << '\x' + byte
		  end

		  @hex = @hex.join

	else

		  hex_ary = @file2read

		  type = BofKUtils::Decoration.new

		  hex_ary.map do |byte|
			@hex << '\x' + byte
		  end

		  formatted = type.format(@hex , format , 15)
		  holder    = ""

		  formatted.map do |l|
			  if l != formatted.last
				holder << "\"#{l[0..-2].join}\"" + l.last
			  else
				holder << "\"#{l[0..-2].join}\"" + l.last
			  end
		  end

		  @hex = holder

	end

	return @hex
  end

end





