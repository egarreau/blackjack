## ruby blackjack.rb
# new game
# ==> 2 cards
# hit
# ==> another card
# stand
#  ==> bust or win

require 'httparty'
require 'pry'

class DeckOfCards
  attr_reader :id, :card_count
  
  def initialize
    response = HTTParty.get('https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1')
    @id = response['deck_id']
    @card_count = response['remaining']
  end

  def draw(number_of_cards)
    response = HTTParty.get("https://deckofcardsapi.com/api/deck/#{@id}/draw/?count=#{number_of_cards}")
    cards = response["cards"]
  end
end

class Blackjack
  attr_reader :deck

  def initialize
    @deck = DeckOfCards.new
  end

  def game
    puts deal
    command = gets.chomp
    if command == "hit"
      puts hit
    end
  end

  def deal
    parse_cards(@deck.draw(2))
  end

  def hit
    parse_cards(@deck.draw(1))
  end

  def parse_cards(card_array)
    card_array.map! do |card|
      "#{card['value']} of #{card['suit'].downcase}"
    end
  end
end

Blackjack.new.game
