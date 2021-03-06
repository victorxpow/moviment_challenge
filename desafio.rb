def manage_arr(array)
  arr = array.map do |string|
    values = string.gsub('\n', '').split(',')
    values = [values.first, values.last.to_i]
  end

  Hash[*arr.flatten]
end

def transaction(account_number, value)
  result = @accounts[account_number] + value
  result -= 300 if result < 0

  @accounts[account_number] = result

  @accounts
end

@accounts = manage_arr(File.readlines(ARGV[0]))
transactions = File.readlines(ARGV[1]).map do |line|
  line.gsub('\n', '').split(',').map(&:to_i)
end

transactions.each do |transaction|
  transaction(transaction[0].to_s, transaction[1])
end

@accounts.each do |key, value|
  print "#{key},#{value}\n"
end