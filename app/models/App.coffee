#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @newGame()
    @get('playerHand').on('stand',@stand,@)
    @get('playerHand').on('busted',@busted,@)
    @get('dealerHand').on('dealerBust',@dealerBust,@)
    @get('dealerHand').on('dealerDone',@dealerDone, @)
    @get('playerHand').on('newGame',@newGame, @)

  newGame: ->
    console.log 'new game'
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'status', 'Make. Your. Move.'

  stand: ->
    @get('dealerHand').dealerHit()

  busted: ->
    @set 'status','Busted. Dealer wins!'
    @trigger 'gameOver'

  dealerBust: ->
    if @get('playerHand').scores()[0] <= 21
      @set 'status','Dealer bust. You win!'
      @trigger 'gameOver'

  dealerDone: ->
    if @get('playerHand').scores()[0] > @get('dealerHand').scores()[0]
     @set 'status','You win!'
     @trigger 'gameOver'
    else if @get('playerHand').scores()[0] < @get('dealerHand').scores()[0]
      @set 'status','Dealer wins! :('
      @trigger 'gameOver'
    else 
      @set 'status',"It's a tie!"
      @trigger 'gameOver'