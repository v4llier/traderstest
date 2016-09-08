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
    @result = (num1.fdiv(num2)).round(3)
  else
    @result = (num1.send(@operation, num2)).round(3)
  end

end

def number_operator(num1, num2)
  @random_choices = %w(1 2 3 4)
  @random = @random_choices.sample.to_i
  if @random == 1
    @num1 = num1
    @num2 = num2
  elsif @random == 2
    @num1 = -num1
    @num2 = -num2
  elsif @random == 3
    @num1 = -num1
    @num2 = num2
  else
    @num1 = num1
    @num2 = -num2
  end
  result(@num1,@num2)
  wrong_answers
end


def calculation
  operation
  if @operation == :/
    @division_calculus = rand(1..5)
    if @division_calculus < 0
      dividable_pool
      @dividable_numbers = @pairs.sample
      @num1 = @dividable_numbers[1]
      @num2 = @dividable_numbers[0]
    else
      decimal_numbers_choice
      number_operator(@num1,@num2)
    end
  elsif @operation == :*
    decimal_numbers_choice
    number_operator(@num1,@num2)
  else
    decimal_numbers_choice
    number_operator(@num1,@num2)
  end
end

def dividable_pool
  mx = 200
  @pairs = (2..mx/2).flat_map { |n| (2..mx/n).map { |m| [n, n*m] } }
end

def dividable_numbers
  @dividable_numbers = [
    @num_cent_a,
    @num_deci_a,
    @num_deci_b,
    @num_unit_a,
    @num_unit_b,
    @num_centi,
    @num_centi_lg,
    @num_milli_uniq,
    @num_centi_uniq,
  ]
  num1 = @dividable_numbers.sample
  num2 = @dividable_numbers.sample
  @num2 = num1.round(3)
  @num1 = (num1 * num2).round(3)
end

# def division_pairs
#   @pairs = [
#     [@num_cent_a,@num_deci_a],
#     [@num_deci_b,@num_deci_a],
#     [@num_unit_a,@num_centi],
#     [@num_centi_lg,@num_unit_b],
#     [@num_unit_a,@num_milli_uniq],
#     [@num_centi,@num_deci_b],
#     [@num_milli_uniq,@num_centi_uniq],
#     [@num_centi_uniq,@num_deci_b],
#     [@num_unit_b,@num_deci_a],
#     [@num_deci_lg,@num_deci_divided_100],
#     [@num_deci_lg,@num_deci_divided_200],
#     [@num_deci_lg,@num_deci_divided_50],
#     [@num_unit_a,@num_unit_b]
#   ]
#   @pairs_choice = @pairs.sample
#   @num1 = @pairs_choice[0]
#   @num2 = @pairs_choice[1]
# end




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
    # division_pairs
    dividable_numbers
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
  @num_mille_a = rand(50..9999)
  @num_mille_b = rand(50..9999)
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
  @num_centi_uniq,
  @num_mille_b,
  @num_mille_b,
  ]
end

def define_last_number
  if @decimals <= 1 && @result.to_s[/\d$/] == "0"
    @result.to_s[/\d(?=\.\w+)/]
  else
    @result.to_s[/\d$/]
  end
end

def last_number_check(answer,result)
  if @decimals <= 1 && result.to_s[/\d$/] == "0"
    (answer.to_s[/\d(?=\.\w+)/] == result.to_s[/\d(?=\.\w+)/]) && (answer.to_s[/\d$/] == result.to_s[/\d$/])
  else
    (answer.to_s[/\d$/] == result.to_s[/\d$/])
  end
end

def decimal_size
  @result.to_s.split('.').last.size
end


def wrong_answers
  @decimals = decimal_size
  if @operation == :+
    @wrong_answer_one = (@num1 - @num2).round(3)
    @wrong_answer_two = - @result.round(3)
    @wrong_answer_three = - @wrong_answer_one.round(3)
    # @wrong_answers = [@wrong_answer_one, @wrong_answer_two, @wrong_answer_three]
  elsif @operation == :-
    @wrong_answer_one = (@num1 + @num2).round(3)
    @wrong_answer_two = - @result.round(3)
    @wrong_answer_three = - @wrong_answer_one.round(3)
    # @wrong_answers = [@wrong_answer_one, @wrong_answer_two, @wrong_answer_three]
  else
    if @result.to_s[/.\./] == "0." && @result.to_s.size == 3
      @wrong_answer_one = (@result + rand(1..10)).round(@decimals)
      @wrong_answer_two = (@result + rand(1..10)).round(@decimals)
        until @wrong_answer_two != @wrong_answer_ones
          @wrong_answer_two = (@result + rand(1..10)).round(@decimals)
        end
      @wrong_answer_three = (@result + rand(1..10)).round(@decimals)
        until @wrong_answer_three != @wrong_answer_ones && @wrong_answer_three != @wrong_answer_two
          @wrong_answer_three = (@result + rand(1..10)).round(@decimals)
        end

    elsif @result.to_s[/.\./] == "0." && @result.to_s.size == 4 && @result.to_s[/-/] == "-"
      @wrong_answer_one = (@result - rand(1..3)).round(@decimals)
      @wrong_answer_two = (@result - rand(1..5)).round(@decimals)
        until @wrong_answer_two != @wrong_answer_one
          @wrong_answer_two = (@result - rand(1..5)).round(@decimals)
        end
      @wrong_answer_three = (@result - rand(1..6)).round(@decimals)
        until @wrong_answer_three != @wrong_answer_one && @wrong_answer_three != @wrong_answer_two
          @wrong_answer_three = (@result - rand(1..6)).round(@decimals)
        end

    elsif (@result.to_s[/\.0?0/] == ".0" || @result.to_s[/\.0?0/] == ".00") &&
      (@result.to_s[/.\./] == "0.") &&
      (@result.to_s[/\d$/] == "1")
      @wrong_answer_one = (@result * rand(1..8))
        until
            (@wrong_answer_one != @result) &&
            (@decimals == @wrong_answer_one.to_s.split('.').last.size)
          @wrong_answer_one = (@result * rand(1..8)).round(@decimals)
        end
      @wrong_answer_two = (@result * rand(1..8)).round(@decimals)
      until
          (@wrong_answer_two != @result) &&
          (@decimals == @wrong_answer_two.to_s.split('.').last.size) &&
          (@wrong_answer_two != @wrong_answer_one)
        @wrong_answer_two = (@result * rand(1..8)).round(@decimals)
      end
      @wrong_answer_three = (@result * rand(1..8)).round(@decimals)
      until
          (@wrong_answer_three != @result) &&
          (@decimals == @wrong_answer_three.to_s.split('.').last.size) &&
          (@wrong_answer_three != @wrong_answer_two) &&
          (@wrong_answer_three != @wrong_answer_one)
        @wrong_answer_three = (@result * rand(1..8)).round(@decimals)
      end

    elsif (@result.to_s[/\.0?0/] == ".0" || @result.to_s[/\.0?0/] == ".00") &&
        (@result.to_s[/.\./] == "0.")
      @wrong_answer_one = (@result * rand(0.1..20.2))
      until
          (@wrong_answer_one != @result) &&
          (last_number_check(@wrong_answer_one,@result)) &&
          (@decimals == @wrong_answer_one.to_s.split('.').last.size)
        @wrong_answer_one = (@result * rand(0.1..20.2)).round(@decimals)
      end
      @wrong_answer_two = (@result * rand(0.95..30.05)).round(@decimals)
      until
          (@wrong_answer_two != @result) &&
          (last_number_check(@wrong_answer_two,@result)) &&
          (@decimals == @wrong_answer_two.to_s.split('.').last.size) &&
          (@wrong_answer_two != @wrong_answer_one)
        @wrong_answer_two = (@result * rand(0.1..20.2)).round(@decimals)
      end
      @wrong_answer_three = (@result * rand(0.95..1.05)).round(@decimals)
      until
          (@wrong_answer_three != @result) &&
          (last_number_check(@wrong_answer_three,@result)) &&
          (@decimals == @wrong_answer_three.to_s.split('.').last.size) &&
          (@wrong_answer_three != @wrong_answer_two) &&
          (@wrong_answer_three != @wrong_answer_one)
        @wrong_answer_three = (@result * rand(0.1..20.2)).round(@decimals)
      end

    elsif (@result.abs > 11) ||
        (@decimals > 1) ||
        (@result.to_s.size == 3 && @result.to_s[/\d$/] != "0") ||
        (@result.to_s.size == 4 && @result.to_s[/-/] == "-" && @result.to_s[/\d$/] != "0")
      @wrong_answer_one = (@result * rand(0.95..1.05)).round(@decimals)
      until
          (@wrong_answer_one != @result) &&
          (last_number_check(@wrong_answer_one,@result)) &&
          (@decimals == @wrong_answer_one.to_s.split('.').last.size)
        @wrong_answer_one = (@result * rand(0.1..2.4)).round(@decimals)
      end
      @wrong_answer_two = (@result * rand(0.95..1.05)).round(@decimals)
      until
          (@wrong_answer_two != @result) &&
          (last_number_check(@wrong_answer_two,@result)) &&
          (@decimals == @wrong_answer_two.to_s.split('.').last.size) &&
          (@wrong_answer_two != @wrong_answer_one)
        @wrong_answer_two = (@result * rand(0.1..2.4)).round(@decimals)
      end
      @wrong_answer_three = (@result * rand(0.95..1.05)).round(@decimals)
      until
          (@wrong_answer_three != @result) &&
          (last_number_check(@wrong_answer_three,@result)) &&
          (@decimals == @wrong_answer_three.to_s.split('.').last.size) &&
          (@wrong_answer_three != @wrong_answer_two) &&
          (@wrong_answer_three != @wrong_answer_one)
        @wrong_answer_three = (@result * rand(0.1..2.4)).round(@decimals)
      end

    else
      @wrong_answer_one = (@result + rand(1..10)).round(@decimals)
      @wrong_answer_two = (@result - rand(1..10)).round(@decimals)
      @wrong_answer_three = (@result + rand(1..10)).round(@decimals)
        until @wrong_answer_three != @wrong_answer_one
          @wrong_answer_three = (@result + rand(1..10)).round(@decimals)
        end
    end
  end
  @wrong_answers = [@wrong_answer_one, @wrong_answer_two, @wrong_answer_three]
end

def answers(answer)
  @answer = answer.round(3)
  @choice = rand(1..4)

  if @choice == 1
    @choice_one = @answer
  else
    @choice_one = @wrong_answers.sample
  end

  if @choice == 2
    @choice_two = @answer
  else
    @choice_two = @wrong_answers.sample
    until @choice_two != @choice_one
      @choice_two = @wrong_answers.sample
    end
  end

  if @choice == 3
    @choice_three = @answer
  else
    @choice_three = @wrong_answers.sample
    until @choice_three != @choice_one && @choice_three != @choice_two
      @choice_three = @wrong_answers.sample
    end
  end

  if @choice == 4
    @choice_four = @answer
  else
    @choice_four = @wrong_answers.sample
    until @choice_four != @choice_one && @choice_four != @choice_two && @choice_four != @choice_three
      @choice_four = @wrong_answers.sample
    end
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
  puts %Q(You answer with the keys "1" "2" "3" or "4". When the time is over, press ENTER)
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
          @na += 1
          puts "you passed this question"
        else
          puts "Wrong command please try again"

      end
      @total = @right + @wrong + @na
      # puts "#{@answer}"
      puts puts

    end
  @right
  @na
  @percentage = (@right.fdiv(@total) * 100).round(0)

  puts %Q(not answered: #{@na})
  puts %Q(right: #{@right})
  puts %Q(wrong: #{@wrong})
  puts

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



