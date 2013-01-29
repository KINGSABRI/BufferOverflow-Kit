BufferOverflow-Kit
==================

We collect many tools used in buffer overflow development in one place, repeating with new idea is not a shame - thanks China :)
If you are a buffer overflow guy, then may you like to contriute and develop with us more tools in one place.

*What BufferOverflow Kit contain*
---------------------------------
* pattern create (like metasploit pattern_create script)
* pattern offset (like metasploit pattern_offset script)
* Hex to Little endian chracter (ex. \x41\x\42\x\43\x44 to \x44\x43\x42\x41)
* Convert Hex shellcode to Binary file
* Convert Binary file to Hex raw
* and more ,,

*How to use?*
--------------
make sure your ruby is install
**Help**

	ruby bofk-cli.rb -h
	Usage:
	ruby bofk-cli.rb --pattern-create 500
	ruby bofk-cli.rb --pattern-offset Aa4Z
	ruby bofk-cli.rb --hex2endl 0x41F2E377
	ruby bofk-cli.rb --hex2bin input.txt output.bin
	ruby bofk-cli.rb --bin2hex input.bin output.txt
	
	    -c, --pattern-create LENGTH      Create Unique pattern string
	    -o, --pattern-offset OFFSET      Find Pattern offset string.
	    -e, --hex2lend OPCODE            Convert Hex to little endian characters.
	    -b, --hex2bin                    Convert Hex shellcode to binary file.
	    -x, --bin2hex                    Convert binary shellcode to Hex string.
	    -h, --help                       Display this screen 

**Pattern create**

	bofk-cli.rb --pattern-create 50
	Aa0AAa0BAa0CAa0DAa0EAa0FAa0GAa0HAa0IAa0JAa0KAa0LAa

**Pattern offset**

	ruby bofk-cli.rb --pattern-offset GAa0
	27

**Convert to little endian**

	ruby bofk-cli.rb -e \x41\x\42\x\43\x44
	\x44\x43\x42\x41

