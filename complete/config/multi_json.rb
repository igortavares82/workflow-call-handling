require 'multi_json'

if RUBY_PLATFORM == 'java'
  require 'jrjackson'

  MultiJson.use :jr_jackson
else
  require 'oj'

  MultiJson.use :oj
end
