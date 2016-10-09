puts 'Enter Post Title'
title = gets.chomp
puts 'Enter Date'
post_date = gets.chomp
puts 'Enter image file'
image_file = gets.chomp

res = title.downcase.gsub(/\s+/) { |m| '-' }

file_name = "./_posts/#{post_date}-#{res}.markdown"

content = <<~HEREDOC
---
layout: post
title:  "#{title}"
date:   #{post_date} 00:48:28 -0400
image: #{image_file}.jpg
categories: haha
---
HEREDOC

File.open(file_name, 'w') { |file| file.write(content) }

system("cp ~/Pictures/#{image_file}.jpg ./img/#{image_file}.jpg")
system("cp ~/Pictures/#{image_file}.jpg ./img/thumbs/#{image_file}.jpg")
system("mogrify -auto-orient -resize 1200 ./img/#{image_file}.jpg")
system("mogrify -auto-orient -resize 220 ./img/thumbs/#{image_file}.jpg")