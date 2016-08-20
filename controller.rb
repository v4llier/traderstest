def operation
  syms = [:+, :/, :-, :*, :+, :+, :-, :-]
  @operation = syms.sample
end

def result(num1, num2)
  if @operation == :/
    @result = num1/num2
  else
    @result = num1.send(@operation, num2)
  end
end

def calculation
  operation
  if @operation == :/
    dividable_pool
    @dividable_numbers = @pairs.sample
    @num1 = @dividable_numbers[1]
    @num2 = @dividable_numbers[0]
    result(@num1,@num2)
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

def decimal_numbers_choice
  numbers
  if @operation == :*
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
  @num_milli_lg = rand(0.001..15).round(3)
  @num_centi_lg = rand(0.01..30).round(2)
  @num_centi = rand(0.01..0.99).round(2)

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
  @num_centi_lg,
  @num_centi,
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

def program
  @right = 0
  @wrong = 0
  @total = 0

  puts "How many questions do you want?"
  puts
  @number_questions = gets.chomp

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
          puts "Perfect!"
          @right += 1
        else
          puts "wrong answer, the answer was #{@answer}"
          @wrong += 1
        end

      when 2
        if @choice_two == @answer
          puts "Perfect!"
          @right += 1
        else
          puts "wrong answer, the answer was #{@answer}"
          @wrong += 1
        end
      when 3
        if @choice_three == @answer
          puts "Perfect!"
          @right += 1
        else
          puts "wrong answer, the answer was #{@answer}"
          @wrong += 1
        end
      when 4
        if @choice_four == @answer
          puts "Perfect!"
          @right += 1
        else
          puts "wrong answer, the answer was #{@answer}"
          @wrong += 1
        end
      else
        puts "invalid command"
        calculation
    end
    @total = @right + @wrong
    puts puts

  end
  @right
  @percentage = (@right.fdiv(@total) * 100).round(0)

  puts "You got #{@right} answer(s) right (#{@percentage}%)"
end

program

