#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @newGame()
    @get('playerHand').on('stand',@stand,@)
    @get('playerHand').on('busted',@busted,@)
    @get('dealerHand').on('dealerBust',@dealerBust,@)
    @get('dealerHand').on('dealerDone',@dealerDone, @)
    @on('newGame',@newGame, @)

  newGame: ->
    console.log 'new game'
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'status', 'Make. Your. Move.'

  stand: ->
    @get('dealerHand').at(0).flip()
    @get('dealerHand').dealerHit()

  busted: ->
    @set 'status','Bust. Dealer wins!'
    @trigger 'gameOver'

  dealerBust: ->
    if @get('playerHand').scores() <= 21
      @set 'status','Dealer bust. You win!'
      @trigger 'gameOver'

  dealerDone: ->
    if @get('playerHand').scores() > @get('dealerHand').scores()
     @set 'status','You win! That rabbit foot sure is useful.'
     @trigger 'gameOver'
    else if @get('playerHand').scores() < @get('dealerHand').scores()
      @set 'status','Dealer wins! :('
      @trigger 'gameOver'
    else 
      @set 'status',"It's a tie! How boring."
      @trigger 'gameOver'

