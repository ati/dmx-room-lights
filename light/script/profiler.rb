# compatible with ruby 1.8
require 'ruby-prof'

v = 0
galaxy = Galaxy.find(1)
h = rand(360)
s = rand(100)

RubyProf.start
  ActiveRecord::Base.cache do
    100.times {galaxy.display_hsv(h, s, v)}
  end
result = RubyProf.stop

#printer = RubyProf::GraphHtmlPrinter.new(result)
printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)
