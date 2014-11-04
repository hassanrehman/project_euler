require 'date'

starting = Date.parse("1 Jan 1901")
ending = Date.parse("31 Dec 2000")

current = starting

sundays = 0
while current <= ending do
  sundays += 1 if current.sunday?
  current = current.next_month
end
puts sundays