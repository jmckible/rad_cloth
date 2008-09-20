begin
  require 'RedCloth'
rescue LoadError
  nil
end

require 'textile'

ActiveRecord::Base.send :include, Textile