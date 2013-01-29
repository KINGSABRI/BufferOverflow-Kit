#!/usr/bin/env ruby
=begin
pattern create
pattern offset
endian little character converter
hex2bin
bin2hex
=end

APP_ROOT	= Dir.pwd
ROOT		= $:.unshift(File.join(APP_ROOT, "bin"))
LIB		= "#{APP_ROOT}/lib"
OUT		= "#{APP_ROOT}/out"



require	'pry'
require	'pattern'

pattern = Pattern.new

### Commands Setting ###

Pry.commands = Pry::CommandSet.new

# Pry.commands.create_command "pattern" do
#   description "pattern is command do 2 jobs ,, pattern create [integer] | pattern offset [string]"
#   
#   p @pattern = Pattern.new
#   
#   def options(opt)
#     opt.on :c, :create, "Create Uniqe pattern according to argument integer value"
#     opt.on :o, :offset, "Find the possition of string you're looking for"
#   end
#   
#   def process
#     input = args.join(" ")
#     p input
#     p @pattern
#     if opts.create?
# #       puts @pattern.create(input.to_i)
#     elsif opts.offset?
# #       @pattern.offset(input.to_s)
#     end
#   end
# end

## Commands Setting ##
command_set = Pry::CommandSet.new do
  
  block_command "cmd1", "pattern is command do 2 jobs ,, pattern create [integer] | pattern offset [string]." do |name|
    output.puts "CMD1 outputs"
    print "[-] Purchase Type [online|live]: "
    type = gets
    print "[-] Course [PWB|CTP]: "
    course = gets 
  end

end 

Pry.commands.create_command "exit" , "Exit BoF Kit console" do
  def process
    exit 1
  end
end


Pry.commands.import_from Pry::Commands, "help"

## EOF commands Setting 


## refresh pry inline
# _pry_.refresh


# Pry Configurations 
Pry.config.hooks.add_hook(:when_started, :logo1) do
  puts "when: puts your logo1"
end
Pry.config.hooks.add_hook(:after_session, :logo2) do
  puts "after: Have a nice console!!\n\n\n"
end
Pry.config.hooks.add_hook(:before_eval, :kill_ruby) { |code, _| code.clear }	# Disable Pry as Ruby Interpreter
# Pry.config.hooks.add_hook(:before_eval, :kill_ruby) { |code, _| code.replace "" }

Pry.config.auto_indent 	= false		# Disable identation 
Pry.config.color 	= false		# Disable color
# Pry.config.pager 	= false		# Disable pager
Pry.config.memory_size 	= 300		# Increas the size of the cache
Pry.config.print = proc { |*| }		# Disable Pry outputs


# Start the console 
Pry.start(self, :prompt => [proc { "ENTER INPUT> " }])























