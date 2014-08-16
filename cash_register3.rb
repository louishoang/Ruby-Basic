require 'csv'
require 'pry'
 
def return_sku (hash, number)
 
  answer = hash.first(number)
  return answer[-1][0]
end
 
 
total = 0
items = {}
daily_sales = {}
 
puts "Welcome to James' coffee emporium!\n\n"
 
CSV.foreach('products.csv', headers: true, :header_converters => :symbol, :converters => :all) do |row|
  items[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])]
end
 
 
i = 1
items.each do |key, value|
  puts "#{i}) Add item - $#{sprintf("%.2f", value[:retail_price])} - #{value[:name]}"
  i += 1
end
 
puts "#{i}) Complete Sale\n\n"
 
print "Make a selection:\n> "
user_choice = gets.chomp.to_i
 
while user_choice < i
 
  user_sku = return_sku(items, user_choice)
  print "How many?\n> "
  user_quantity = gets.chomp.to_i
 
  total += (items[user_sku][:retail_price]*user_quantity)
 
  print "\nSubtotal: #{sprintf("%.2f", total)}\n\n"
  unless daily_sales.has_key?(user_sku)
    daily_sales[user_sku] = 0
  end
    daily_sales[user_sku] += user_quantity
 
  # Increment the count for the word by one.
  print "Make a selection:\n > "
  user_choice = gets.chomp.to_i
end
print "===Sale Complete===\n\n"
daily_sales.each do |key, value|
  print "$#{sprintf("%.2f", (value*items[key][:retail_price]))} - #{value} #{items[key][:name]}\n"
end
 
puts "Total: $#{sprintf("%.2f", total)}"
puts "\nWhat is the amount tendered?"
print '>'
cash = gets.chomp.to_f
 
if total > cash
  puts "WARNING: Customer still owes $#{sprintf("%.2f", (total - cash))}! Exiting..."
  exit
end
 
puts '===Thank You!==='
puts "The total change due is $#{sprintf("%.2f", (cash - total))}"
puts
puts "#{Time.new.strftime('%m/%d/%Y %l:%M%p')}"
 
CSV.open("salesreport.csv", "w") do |csv|
  daily_sales.each do |k, v|
    csv << [k, v]
  end
end
