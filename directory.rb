def input_students
  puts 'Please enter the names of the students,
and optionally with cohort separated by comma'
  puts 'To finish, just hit return twice'
  students = []
  input = gets.chomp
  cohorts = %w[january february march april may june july august september
               october november december]
  until input.empty?
    input = input.split(',')
    input << 'november' if input.length == 1 && !cohorts.include?(input[0].strip.downcase)
    input.insert(0, 'Dracula') if input.length == 1 && cohorts.include?(input[0].strip.downcase)
    students << { name: input[0].strip, cohort: input[1].strip.to_sym,
                  hobby: :coding }
    puts "Now we have #{students.count} students"
    input = gets.chomp
  end
  students
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print(students)
  hash = students.group_by { |student| student[:cohort]}
  hash.each do |cohort, data|
    puts cohort
    data.each { |student| puts student[:name] }
    puts ''
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# students = input_students

# TESTS
students = [
  { name: 'Dr. Hannibal Lecter', cohort: :november },
  { name: 'Darth Vader', cohort: :november },
  { name: 'Nurse Ratched', cohort: :november },
  { name: 'Michael Corleone', cohort: :november },
  { name: 'Alex DeLarge', cohort: :november },
  { name: 'The Wicked Witch of the West', cohort: :december },
  { name: 'Terminator', cohort: :november },
  { name: 'Freddy Krueger', cohort: :november },
  { name: 'The Joker', cohort: :november },
  { name: 'Joffrey Baratheon', cohort: :december },
  { name: 'Norman Bates', cohort: :november }
]
# print_header
print(students)
#print_footer(students)
