def operation
  syms = [:+, :/, :-, :*, :+, :+, :-, :-]
  @operation = syms.sample
end

def result(num1, num2)
  if @operation == :/
    @answer = num1/num2
  else
    @answer = num1.send(@operation, num2)
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
    numbers_multiplier
    result(@num1,@num2)
  else
    numbers
    result(@num1,@num2)
  end
end

def dividable_pool
  mx = 200
  @pairs = (2..mx/2).flat_map { |n| (2..mx/n).map { |m| [n, n*m] } }
end

def numbers_multiplier
  @num1 = rand(1..100)
  @num2 = rand(1..25)
end

def numbers
  @num1 = rand(1..100)
  @num2 = rand(1..100)
end


# def number_alpha
#   @alpha = rand(1..100)
# end

# def number_beta
#   @beta = rand(1..100)
# end

# def answer
#   if @operation == :/
#     @answer = @alpha.send(@operation, @beta)

#   else
#     @answer = @alpha.send(@operation, @beta)
#   end

# end

def answers(answer)
  @answer = answer
  @choice = rand(1..4)
  if @choice == 1
    @choice_one = @answer
  else
    @choice_one = @answer + rand(1..10)
  end

  if @choice == 2
    @choice_two = @answer
  else
    @choice_two = @answer - rand(1..10)
  end

  if @choice == 3
    @choice_three = @answer
  else
    @choice_three = @answer + rand(1..10)
  end

  if @choice == 4
    @choice_four = @answer
  else
    @choice_four = (@answer * rand(0.5..1.5)).round(0)
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
  @number_questions = gets.chomp

  until @total == @number_questions.to_i
    @total += 1
    calculation
    puts "Question #{@total}/#{@number_questions.to_i}"
    puts "#{@num1}" + " #{@operation} " + "#{@num2}"

    puts answers(@answer)

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
      when ! %w(1 2 3 4)
        puts "invalid command"
        calculation
    end
    @total = @right + @wrong
    # puts "right: #{@right}"
    # puts "wrong: #{@wrong}"
    puts "Question: #{@total}"
    puts puts

  end
  puts "You got #{@right} answer(s) right"
end

program

