# 4つの数字を四則演算で10にする
def main
  error_msg_arr = []

  unless ARGV.length == 4
    error_msg_arr.push 'arguments length must be 4.'
  end
  unless ARGV.all?{|v| v =~ /^[0-9]+$/}
    error_msg_arr.push 'arguments must be number.'
  end

  if error_msg_arr.length == 0
    numbers = ARGV
    number_calculate(numbers.map(&:to_f))
  else
    p 'error:'
    puts error_msg_arr.join("\n")
  end
end

def number_calculate(numbers)
  res = numbers_combi(numbers)
  ops = ops_combi(['+', '-', '*', '/'])
  formula = []
  calculated = []
  matched_count = 0
  res.each do |v|
    ops.each do |op|
       arr = [
        "#{v[0]} #{op[0]} #{v[1]} #{op[1]} #{v[2]} #{op[2]} #{v[3]}",
        "(#{v[0]} #{op[0]} #{v[1]}) #{op[1]} #{v[2]} #{op[2]} #{v[3]}",
        "#{v[0]} #{op[0]} (#{v[1]} #{op[1]} #{v[2]}) #{op[2]} #{v[3]}",
        "#{v[0]} #{op[0]} #{v[1]} #{op[1]} (#{v[2]} #{op[2]} #{v[3]})",
        "(#{v[0]} #{op[0]} #{v[1]}) #{op[1]} (#{v[2]} #{op[2]} #{v[3]})",
        "(#{v[0]} #{op[0]} #{v[1]} #{op[1]} #{v[2]}) #{op[2]} #{v[3]}",
        "((#{v[0]} #{op[0]} #{v[1]}) #{op[1]} #{v[2]}) #{op[2]} #{v[3]}",
        "(#{v[0]} #{op[0]} (#{v[1]} #{op[1]} #{v[2]})) #{op[2]} #{v[3]}",
        "#{v[0]} #{op[0]} (#{v[1]} #{op[1]} #{v[2]} #{op[2]} #{v[3]})",
        "#{v[0]} #{op[0]} ((#{v[1]} #{op[1]} #{v[2]}) #{op[2]} #{v[3]})",
        "#{v[0]} #{op[0]} (#{v[1]} #{op[1]} (#{v[2]} #{op[2]} #{v[3]}))",
      ]
      formula.push arr
      calculated.push arr.map{|a| eval(a)}
    end
  end
  formula.flatten!
  calculated.flatten!
  calculated.each_with_index do |c, i|
    if (c - 10).abs <= 0.001
      p ("#{formula[i]} = #{c}").gsub('.0','')
      matched_count += 1
    end
  end
  if matched_count == 0
    p 'result is not found.'
  end

end

def numbers_combi(arr)
  arr.permutation
end

def ops_combi(arr)
  arr.repeated_permutation(3)
end





main
