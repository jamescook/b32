require 'mkmf'

dir_config('b32')
if find_header 'base32.h', File.expand_path(File.dirname(__FILE__))
  create_makefile('b32')
else
  raise "Could not find base32.h"
end
