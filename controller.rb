def operation
  # out of twenty question + appears 6 times, - 6 times, * 5 times, / 3 times
  syms = [
    :+, :+, :+, :+, :+, :+,
    :-, :-, :-, :-, :-, :-,
    :*, :*, :*, :*, :*,
    :/, :/, :/,
  ]
  @operation = syms.sample
end

def result(num1, num2)
  if @operation == :/
    @result = num1.fdiv(num2)
  else
    @result = num1.send(@operation, num2)
  end
end

def number_operator(num1, num2)

end

def calculation
  operation
  if @operation == :/
    @division_calculus = rand(1..5)
    if @division_calculus < 3
      dividable_pool
      @dividable_numbers = @pairs.sample
      @num1 = @dividable_numbers[1]
      @num2 = @dividable_numbers[0]
      result(@num1,@num2)
    else
      decimal_numbers_choice
      result(@num1,@num2)
    end
  elsif @operation == :*
    decimal_numbers_choice
    result(@num1,@num2)
  else
    decimal_numbers_choice
    result(@num1,@num2)
  end
end

def dividable_pool
  mx = 200
  @pairs = (2..mx/2).flat_map { |n| (2..mx/n).map { |m| [n, n*m] } }
end

def division_pairs
  @pairs = [
    [@num_cent_a,@num_deci_a],
    [@num_deci_b,@num_deci_a],
    [@num_unit_a,@num_centi],
    [@num_centi_lg,@num_unit_b],
    [@num_unit_a,@num_milli_uniq],
    [@num_centi,@num_deci_b],
    [@num_milli_uniq,@num_centi_uniq],
    [@num_centi_uniq,@num_deci_b],
    [@num_unit_b,@num_deci_a],
    [@num_deci_lg,@num_deci_divided_100],
    [@num_deci_lg,@num_deci_divided_200],
    [@num_deci_lg,@num_deci_divided_50],
    [@num_unit_a,@num_unit_b]
  ]
  @pairs_choice = @pairs.sample
  @num1 = @pairs_choice[0]
  @num2 = @pairs_choice[1]
end

def multiplication_pairs
  @pairs = [
    [@num_cent_a,@num_cent_b],
    [@num_cent_a,@num_deca_a],
    [@num_cent_b,@num_deci_a],
    [@num_cent_b,@num_deci_lg],
    [@num_deca_b,@num_deci_b],
    [@num_deca_a,@num_deca_b],
    [@num_unit_a,@num_centi],
    [@num_unit_b,@num_centi_lg],
    [@num_unit_a,@num_deci_lg]
  ]
  @pairs_choice = @pairs.sample
  @num1 = @pairs_choice[0]
  @num2 = @pairs_choice[1]
end

def decimal_numbers_choice
  numbers
  if @operation == :*
    multiplication_pairs

  elsif @operation == :/
    division_pairs
  else
    @num1 = @numbers.sample
    @num2 = @numbers.sample
    until @num1 != @num2
      @num2 = @numbers.sample
    end
  end
end
# def numbers_multiplier
#   @num1 = rand(1..100)
#   @num2 = rand(1..25)
# end

def numbers
  @num_cent_a = rand(5..100)
  @num_cent_b = rand(5..100)
  @num_unit_a = rand(2..10)
  @num_unit_b = rand(2..10)
  @num_deca_a = rand(1..50)
  @num_deca_b = rand(1..50)
  @num_deci_lg = rand(0.1..50).round(1)
  @num_deci_a = rand(0.1..0.9).round(1)
  @num_deci_b = rand(0.1..0.9).round(1)
  @num_centi_uniq = rand(0.01..0.09).round(2)
  @num_milli_uniq = rand(0.001..0.009).round(3)
  @num_milli_lg = rand(0.001..15).round(3)
  @num_centi_lg = rand(0.01..30).round(2)
  @num_centi = rand(0.01..0.99).round(2)
  @num_deci_divided_100 = (@num_deci_lg/100).round(3)
  @num_deci_divided_200 = (@num_deci_lg/200).round(3)
  @num_deci_divided_50 = (@num_deci_lg/50).round(3)

  @numbers = [
  @num_cent_a,
  @num_cent_b,
  @num_unit_a,
  @num_unit_b,
  @num_deca_a,
  @num_deca_b,
  @num_deci_lg,
  @num_deci_a,
  @num_deci_b,
  @num_milli_lg,
  @num_milli_uniq,
  @num_centi_lg,
  @num_centi,
  @num_centi_uniq
  ]
end

def answers(answer)
  @answer = answer.round(3)
  @choice = rand(1..4)
  if @choice == 1
    @choice_one = @answer
  else
    @choice_one = (@answer + rand(1..10)).round(3)
  end

  if @choice == 2
    @choice_two = @answer
  else
    @choice_two = (@answer - rand(1..10)).round(3)
  end

  if @choice == 3
    @choice_three = @answer
  else
    @choice_three = (@answer + rand(1..10)).round(3)
  end

  if @choice == 4
    @choice_four = @answer
  else
    @choice_four = (@answer * rand(0.5..1.5)).round(1)
  end


  puts "1. #{@choice_one}"
  puts "2. #{@choice_two}"
  puts "3. #{@choice_three}"
  puts "4. #{@choice_four}"
end

def introduction
  puts "How many questions do you want? (10 = 1min, 20 = 2min, etc.)"
  puts
  @number_questions = gets.chomp
  puts
  @time_seconds = @number_questions.to_i * 6
  @time_minutes = (@time_seconds.fdiv(60)).round(1)
  puts "This is a multiple choice assessment aim to test whether you have enough arithmetic skills to be a trader."
  puts "Set a timer to #{@time_seconds}sec (#{@time_minutes}min)."
  puts %Q(You answer with the keys "1" "2" "3" or "4". When the time is over, answer the key \"0\")
  puts
  puts "To continue press \'ENTER\'"
end

def program
  @right = 0
  @wrong = 0
  @na = 0
  @total = 0

  introduction

  @key_pressed = gets.chomp

    until @total == @number_questions.to_i
      @total += 1
      calculation

      puts "Question #{@total}/#{@number_questions.to_i}"
      puts
      puts "#{@num1}" + " #{@operation} " + "#{@num2}"
      puts

      puts answers(@result)

      @input = gets.chomp.to_i

      case @input
        when 1
          if @choice_one == @answer
            # puts "Perfect!"
            @right += 1
          else
            puts "wrong answer, the answer was #{@answer}"
            @wrong += 1
          end

        when 2
          if @choice_two == @answer
            # puts "Perfect!"
            @right += 1
          else
            puts "wrong answer, the answer was #{@answer}"
            @wrong += 1
          end
        when 3
          if @choice_three == @answer
            # puts "Perfect!"
            @right += 1
          else
            puts "wrong answer, the answer was #{@answer}"
            @wrong += 1
          end
        when 4
          if @choice_four == @answer
            # puts "Perfect!"
            @right += 1
          else
            puts "wrong answer, the answer was #{@answer}"
            @wrong += 1
          end
        when 0
            @na += 0
        else
          puts "invalid command"
          calculation
      end
      @total = @right + @wrong
      # puts "#{@answer}"
      puts puts

    end
  @right
  @percentage = (@right.fdiv(@total) * 100).round(0)

  puts "You got #{@right} answer(s) right (#{@percentage}%)"
  @score = @right * 1 - @wrong * 2
  @passing_rate = 0.6875 * @total

  puts "Your score is #{@score} (max score is #{@total})"
  if @score > @passing_rate
    puts "You passed"
  else
    puts "You failed you needed at least a score of #{@passing_rate.round(0)}"
  end
end

program


