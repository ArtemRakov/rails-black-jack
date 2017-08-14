class PagesController < ApplicationController

  def home
    @bank_score = (params[:bank_score] || pick_bank_score).to_i
    @your_score = (params[:your_score] || pick_player_card).to_i
    if params[:answer] == 'y' || params[:answer] == 'yes'
      @your_score += pick_player_card
    elsif params[:answer] == 'n' || params[:answer] == 'no'
      @message = end_game_message(@your_score, @bank_score)
    end
  end

  private
    def state_of_the_game(player_score, bank_score)
      return "Your score is #{player_score}, bank is #{bank_score}"
    end

  def end_game_message(player_score, bank_score)
    if (player_score == 21 && bank_score != 21)
      return "Black Jack"
    elsif player_score > 21
      return "You lose"
    elsif (player_score > bank_score && player_score < 21)
      return "You beat the bank! You win."
    elsif player_score < bank_score
      return "You lose"
    else # (player_score == 21 && bank_score == 21)
      return "Push"
    end
  end

  def play_game
    # TODO: make the user play from terminal in a while loop that will stop
    #       when the user will not be asking for  a new card
    puts "Card? 'y' or 'yes' to get a new card"
    input = gets.chomp
    pbank = pick_bank_score
    psum = 0
    while input == ("y" || "yes")
      psum += pick_player_card
      puts state_of_the_game(psum,pbank)
      puts "Card? 'y' or 'yes' to get a new card"
      input = gets.chomp
    end
    puts end_game_message(psum, pbank)
  end

  def pick_bank_score
    # TODO: Use Random to get a new random score
    com_card = (16..21).to_a.sample
    return com_card
  end

  def pick_player_card
    # TODO: Use Random to get a new random card
    pl_card = (1..11).to_a.sample
    return pl_card
  end
end
