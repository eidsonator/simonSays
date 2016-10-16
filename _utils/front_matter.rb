time = Time.new
today = time.strftime("%Y-%m-%d")

title = ""
while title === ""
  puts 'Enter Post Title'
  title = gets.chomp
end
puts "Enter Date (default \"#{today}\")"
post_date = gets.chomp
puts 'Enter image path (default "~/Pictures")'
path = gets.chomp

image_file = ""
while image_file === ""
  puts 'Enter image file (no extension)'
  image_file = gets.chomp
end
puts 'Enter image type (default "jpg")'
image_type = gets.chomp

if post_date === ""
  post_date = today
end
if path === ""
  path = "~/Pictures"
end
if image_type === ""
  image_type = "jpg"
end

res = title.downcase.gsub(/\s+/) { |m| '-' }

file_name = "./_posts/#{post_date}-#{res}.markdown"

content = <<~HEREDOC
---
layout: post
title:  "#{title}"
date:   #{post_date} 00:00:00 -0400
image: #{image_file}.jpg
categories: haha
---
HEREDOC

puts "Is this correct? (Y/n)"
puts content
correct = gets.chomp

if correct.casecmp("n") === 0 or correct.casecmp("no") === 0
  puts "Canceled"
  exit
end

File.open(file_name, 'w') { |file| file.write(content) }

system("cp #{path}/#{image_file}.#{image_type} ./img/#{image_file}.#{image_type}")
system("cp #{path}/#{image_file}.#{image_type} ./img/thumbs/#{image_file}.#{image_type}")
system("mogrify -auto-orient -resize 1200 ./img/#{image_file}.#{image_type}")
system("mogrify -auto-orient -resize 220 ./img/thumbs/#{image_file}.#{image_type}")

puts "Completed!"