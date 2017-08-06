$deck =[]
#deck is made global to be accessed by everyone
class Player
	@funds
	@card_num
	def initialize(start_amount)
		@funds = start_amount
	end
	
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
	
	def display_card
		case @card_num
		when $deck[@card_num].number == 11 then puts "Jack of #{$deck[@card_num].suit}"
		when $deck[@card_num].number == 12 then puts "Queen of #{$deck[@card_num].suit}"
		when $deck[@card_num].number == 13 then puts "King of #{$deck[@card_num].suit}"
		else puts "#{$deck[@card_num].number} of #{$deck[@card_num].suit}" 
		end
	end
end
#Player class to store funds and player methods
class Card
	attr_accessor :suit
	attr_accessor :number
	attr_accessor :played
end
#Card class to make instances of each card

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
#Stores all the card objects into an array


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
		cards = []
		
		card1 = Player1.new_card
		Player1.display_card
		card2 = Player1.new_card
		Player1.display_card

		Dcard1 = Dealer.new_card
		Dcard2 = Dealer.new_card
		
		total = $deck[card1].number + $deck[card2].number 
		Dtotal = $deck[Dcard1].number + $deck[Dcard2].number
		
		if total > 21
			puts "Busted your cards total #{total}"
		elsif total == 21
			puts "Blackjack!"
			if Dtotal != 21  
				Player1.add_funds(pot) 
			else
				Player1.add_funds(pot/2)
				Dealer.add_funds(pot/2)
			end
		else
			
		end
		

	else
		puts "Player/Dealer does not the nessecary funds!"
	end
end
=begin
module Play
	Play.pick_card
		card_num = rand(0..52)
		if deck[card_num].played  = false
			deck[card_num].played = true
			return deck[card_num]
		else
		 "Card already played"
		end

end
=end