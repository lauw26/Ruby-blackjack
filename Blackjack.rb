$deck =[]
#deck is made global to be accessed by everyone
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Player class to store funds and player methods
class Player
	@funds
	@card_num
	def initialize(start_amount)
		@funds = start_amount
	end
	#methods below are fun handlers which increases, decreases and displays the player funds.
	def bet(amount)
		@funds -= amount
		return amount
	end
	
	def add_funds(add)
		@funds += add
	end
	
	def funds
		return @funds
	end
	#the method belows loops through the deck randomly and selects the card if it has not been played.
	def new_card
		new_num = 0
		loop do
			new_num = rand(0..52)
		break if $deck[new_num].played  == false 
		end
		@card_num = new_num
		$deck[@card_num].played = true
		return @card_num
	end
	#Used to display the card drawn 
	def display_card
		case $deck[@card_num].number
			when 11 
				puts "Jack of #{$deck[@card_num].suit}"
			when 12
				puts "Queen of #{$deck[@card_num].suit}"
			when 13
				puts "King of #{$deck[@card_num].suit}"
			else 
				puts "#{$deck[@card_num].number} of #{$deck[@card_num].suit}" 
		end
	end
end
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Card class to make instances of each card
class Card
	attr_accessor :suit
	attr_accessor :number
	attr_accessor :played
end
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Stores all the card objects into an array
for i in 0..51
	if i < 13 
		$deck[i] = Card.new
		$deck[i].number = i+1
		$deck[i].suit = "Diamond"
		$deck[i].played = false
	elsif i < 26 && i > 12 
		$deck[i] = Card.new
		$deck[i].number = i - 12
		$deck[i].suit = "Club"
		$deck[i].played = false	
	elsif i < 39 && i > 25 
		$deck[i] = Card.new
		$deck[i].number = i -25
		$deck[i].suit = "Heart"
		$deck[i].played = false	
	else 
		$deck[i] = Card.new
		$deck[i].number = i - 38
		$deck[i].suit = "Spade"
		$deck[i].played = false	
	end
end
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Method to check if the total of cards are within range
def checker(total)

	if total > 21
		return "busted"
	elsif total == 21	
		return "blackjack"
	else
		return "under"	
	end
end	
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Prompt for 
#---------------------------------------------------------------------------------------------------------------------------------------------------
#Main side of code
puts "Welcome to blackjack!"
puts "Please enter the amount to start:"
start_amount = Integer(gets.chomp)
Player1 = Player.new(start_amount)
Dealer = Player.new(start_amount)
until Player1.funds == 0 && Dealer.funds == 0 do

	pot = 0
	puts "Enter the betting amount"
	bet_amount = Integer(gets.chomp)
	if bet_amount <= Player1.funds && bet_amount <= Dealer.funds
		pot = Player1.bet(bet_amount) + Dealer.bet(bet_amount)
		puts "The pot contains £#{pot}"
		extra_cards = []
		
		card1 = Player1.new_card
		Player1.display_card
		card2 = Player1.new_card
		Player1.display_card

		d_card1 = Dealer.new_card
		Dealer.display_card
		d_card2 = Dealer.new_card
		Dealer.display_card

		total = $deck[card1].number + $deck[card2].number 
		d_total = $deck[d_card1].number + $deck[d_card2].number
		
		case total
			when "under"

			when "busted"

			when "blackjack"	
			else 
				puts "error in total case"
		end

	else
		puts "Player/Dealer does not the nessecary funds!"
	end
end

