require 'CSV'
@students = []

def try_load_students
  filename = ARGV.first
  filename = 'students.csv' if filename.nil?
  if File.exist?(filename)
    load_students(filename, false)
  else
    puts "Sorry, #{filename} doesn't exsists"
    exit
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
    puts 
  end
end

def print_menu
  puts ['1. Input the students',
        '2. Show the students',
        '3. Save the list to a file',
        '4. Load the list from a file',
        '9. Exit']
end

def process(selection)
  case selection
  when '1' then input_students
  when '2' then show_students
  when '3' then save_students
  when '4' then load_students
  when '9' then exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts ['Please enter the names of the students',
        'To finish, just hit return twice']
  name = STDIN.gets.chomp
  until name.empty?
    insert_students(name)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  input_success
end

def insert_students(name, cohort = 'november')
  @students << { name: name, cohort: cohort.to_sym }
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  filename = input_filename('s')
  file = File.open(filename, 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
  save_success(filename)
end

def load_students(filename = 'students.csv', input = true)
  filename = input_filename('l') if input
  if File.exist?(filename)
    @students = [] # rewrites the original @students
    read_file(filename)
    load_success(filename)
  else
    puts 'No such a file! Loading was unsuccessful.'
  end
end

def load_success(filename)
  puts "Loaded #{@students.count} from #{filename}"
end

def save_success(filename)
  puts "Saved #{@students.count} student(s) into #{filename}."
end

def input_success
  puts 'Inputting was successful.'
end

def input_filename(mode)
  str_data = ['Enter a filename.',
              'If no filename is given, it will be saved into students.csv.',
              'If no filename is given, it will be loaded from students.csv.']
  puts [str_data[0], (mode == 's' ? str_data[1] : str_data[2])]
  filename = gets.chomp
  filename = 'students.csv' if filename.empty?
  filename
end

def read_file(filename)
  CSV.open(filename, 'rb') do |faster_csv|
    faster_csv.readlines.each do |line|
      name, cohort = line
      insert_students(name, cohort)
    end
  end
end

try_load_students
interactive_menu
