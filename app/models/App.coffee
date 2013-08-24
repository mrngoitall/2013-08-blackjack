#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @newGame()
    @on('newGame',@newGame, @)

  newGame: ->
    @set 'playing', true
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'status', 'Make. Your. Move.'
    @get('playerHand').on('stand',@stand,@)
    @get('playerHand').on('busted',@busted,@)
    @get('dealerHand').on('dealerBust',@dealerBust,@)
    @get('dealerHand').on('dealerDone',@dealerDone, @)

  stand: ->
    @get('dealerHand').at(0).flip()
    @get('dealerHand').dealerHit()

  busted: ->
    @set 'status','Bust. Dealer wins!'
    @gameOver()

  dealerBust: ->
    if @get('playerHand').scores() <= 21
      @set 'status','Dealer bust. You win!'
      @gameOver()

  dealerDone: ->
    if @get('playerHand').scores() > @get('dealerHand').scores()
     @set 'status','You win! That rabbit foot sure is useful.'
     @gameOver()
    else if @get('playerHand').scores() < @get('dealerHand').scores()
      @set 'status','Dealer wins! :('
      @gameOver()
    else 
      @set 'status',"It's a tie! How boring."
      @gameOver()

  gameOver: ->
    @set 'playing', false
    @trigger 'gameOver'