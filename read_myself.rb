File.open($PROGRAM_NAME.to_s, 'r') do |file|
  while line = file.gets
    puts line
  end
end
