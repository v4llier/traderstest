    test_round = [1,2,3]

    # @result = -rand(0.1..100).round(test_round.sample)
    @result = 15.0
    p @result.to_s.size

    p @result.to_s.split('.').last.size

    # def decimals(number)
    #     num = 0
    #     while(number != number.to_i)
    #         num += 1
    #         number *= 10
    #         p number
    #         p num
    #     end
    #     num
    # end

    p @result.to_s[/\d$/]
    p @result.to_s[/\d(?=\.\w+)/]


    def define_last_number
      decimal_size
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
      @decimals = @result.to_s.split('.').last.size
    end

    p @result.to_s[/.\./]
    p @result.to_s[/-/]
    p @result.to_s[/\.0?0/] == ".0"

    p define_last_number
    if @result.to_s[/.\./] == "0." && @result.to_s.size == 3
      @answer = (@result + rand(1..10)).round(@decimals)
      @answer2 = (@result + rand(1..10)).round(@decimals)
      p 1
        until @answer2 != @answers
          @answer2 = (@result + rand(1..10)).round(@decimals)
        end
      @answer3 = (@result + rand(1..10)).round(@decimals)
        until @answer3 != @answers && @answer3 != @answer2
          @answer3 = (@result + rand(1..10)).round(@decimals)
        end


    elsif @result.to_s[/.\./] == "0." && @result.to_s.size == 4 && @result.to_s[/-/] == "-"
      @answer = (@result - rand(1..3)).round(@decimals)
      @answer2 = (@result - rand(1..5)).round(@decimals)
      p 2
        until @answer2 != @answer
          @answer2 = (@result - rand(1..5)).round(@decimals)
        end
      @answer3 = (@result - rand(1..6)).round(@decimals)
        until @answer3 != @answer && @answer3 != @answer2
          @answer3 = (@result - rand(1..6)).round(@decimals)
        end

    elsif (@result.to_s[/\.0?0/] == ".0" || @result.to_s[/\.0?0/] == ".00") &&
      (@result.to_s[/.\./] == "0.") &&
      (@result.to_s[/\d$/] == "1")
      p 4.5
      @answer = (@result * rand(1..8))
        until @answer != @result && @decimals == @answer.to_s.split('.').last.size
          @answer = (@result * rand(1..8)).round(@decimals)
        end
      @answer2 = (@result * rand(1..8)).round(@decimals)
      until @answer2 != @result && @decimals == @answer2.to_s.split('.').last.size && @answer2 != @answer
        @answer2 = (@result * rand(1..8)).round(@decimals)
      end
      @answer3 = (@result * rand(1..8)).round(@decimals)
      until @answer3 != @result && @decimals == @answer3.to_s.split('.').last.size && @answer3 != @answer2 && @answer3 != @answer
        @answer3 = (@result * rand(1..8)).round(@decimals)
      end

    elsif (@result.to_s[/\.0?0/] == ".0" || @result.to_s[/\.0?0/] == ".00") &&
      (@result.to_s[/^./] == "0")
       p 3.5
      @answer = (@result * rand(0.1..20.2))
        until @answer != @result && last_number_check(@answer,@result) && @decimals == @answer.to_s.split('.').last.size
          @answer = (@result * rand(0.1..20.2)).round(@decimals)
        end
      @answer2 = (@result * rand(0.95..30.05)).round(@decimals)
      until @answer2 != @result && last_number_check(@answer2,@result) && @decimals == @answer2.to_s.split('.').last.size && @answer2 != @answer
        @answer2 = (@result * rand(0.1..20.2)).round(@decimals)
      end
      @answer3 = (@result * rand(0.95..1.05)).round(@decimals)
      until @answer3 != @result && last_number_check(@answer3,@result) && @decimals == @answer3.to_s.split('.').last.size && @answer3 != @answer2 && @answer3 != @answer
        @answer3 = (@result * rand(0.1..20.2)).round(@decimals)
      end



    elsif (@result.abs > 16) ||
      (@decimals > 1) ||
      (@result.to_s.size == 3 && @result.to_s[/\d$/] != "0") ||
      (@result.to_s.size == 4 && @result.to_s[/-/] == "-" && @result.to_s[/\d$/] != "0")
      @answer = (@result * rand(0.95..1.05)).round(@decimals)
      p 3
        until @answer != @result && last_number_check(@answer,@result) && @decimals == @answer.to_s.split('.').last.size
          @answer = (@result * rand(0.1..2.2)).round(@decimals)
        end
      @answer2 = (@result * rand(0.95..1.05)).round(@decimals)
      until @answer2 != @result && last_number_check(@answer2,@result) && @decimals == @answer2.to_s.split('.').last.size && @answer2 != @answer
        @answer2 = (@result * rand(0.1..2.2)).round(@decimals)
      end
      @answer3 = (@result * rand(0.95..1.05)).round(@decimals)
      until @answer3 != @result && last_number_check(@answer3,@result) && @decimals == @answer3.to_s.split('.').last.size && @answer3 != @answer2 && @answer3 != @answer
        @answer3 = (@result * rand(0.1..2.2)).round(@decimals)
      end

    else
      p 4
      @answer = (@result + rand(1..8)).round(@decimals)
      @answer2 = (@result - rand(1..7)).round(@decimals)
      @answer3 = (@result + rand(1..5)).round(@decimals)
        until @answer3 != @answers
          @answer3 = (@result + rand(1..6)).round(@decimals)
        end


    end

    p @second
    p @result
    p @answer
    p @answer2
    p @answer3

    # p @answer.to_s[/\d$/] == @result.to_s[/\d$/]
    # p @answer.to_s[/\d(?=\.\w+)/]
    # p @result.to_s[/\d(?=\.\w+)/]
    # p (@answer.to_s[/\d(?=\.\w+)/] == @result.to_s[/\d(?=\.\w+)/])
    #
    #|| @result.to_s[/.\./] != "0."

