# awesome_print
begin
  require "awesome_print"
  AwesomePrint.pry!
rescue LoadError => e
  puts "no awesome_print"
end

