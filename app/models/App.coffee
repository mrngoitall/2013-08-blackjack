#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @newGame()
    @on('newGame',@newGame, @)
    @set 'dealerScore',0
    @set 'playerScore',0

  newGame: ->
    @set 'playing', true
    @set 'winner', null
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
    @set 'winner','dealer'
    @set 'status','Bust. Dealer wins!'
    @gameOver()

  dealerBust: ->
    if @get('playerHand').scores() <= 21
      @set 'status','Dealer bust. You win!'
      @set 'winner','player'
      @gameOver()

  dealerDone: ->
    if @get('playerHand').scores() > @get('dealerHand').scores()
      @set 'winner', 'player'
      @set 'status','You win! That rabbit foot sure is useful.'
      @gameOver()
    else if @get('playerHand').scores() < @get('dealerHand').scores()
      @set 'winner','dealer'
      @set 'status','Dealer wins! :('
      @gameOver()
    else 
      @set 'winner','tie'
      @set 'status',"It's a tie! How boring."
      @gameOver()

  gameOver: ->
    @set 'playing', false
    if @get 'winner' is 'player'
      @set 'playerScore',@get('playerScore')+1
    else if @get 'winner' is 'dealer'
      @set 'dealerScore',@get('dealerScore')+1
    else if @get 'winner' is 'tie'
      @set 'playerScore',@get('playerScore')+1
      @set 'dealerScore',@get('dealerScore')+1
    @trigger 'gameOver'