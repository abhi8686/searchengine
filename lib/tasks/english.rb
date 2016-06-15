File.open("#{File.dirname(__FILE__)}/english.txt", "r") do |f|
  a=[]
  f.each_line do |line|
  	line=line.split
  	a=a+[line[1]]
  	File.open("test.txt", "w+") do |f|
  		a.each { |element| f.puts(element) }
		end
  end
end