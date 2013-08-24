class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
      <button class="new-game-button" hidden>New Game</button>
    <div class="player-status"></div>
    <div class="dealer-score"></div>
    <div class="player-score"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> @newGame()

  initialize: -> 
    @render()
    @model.on 'gameOver', @gameOver, @

  newGame: ->
    @model.trigger 'newGame'
    @render()

  gameOver: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-status').html @model.get 'status'
    @$('.player-status').attr('style', 
      if @model.get('winner') is 'player'
      then 'background: #e5fde4;'
      else if @model.get('winner') is 'dealer'
      then 'background: #ffd9d9;'
      else 'background: #fff0bf;'
    )
    if !@model.get('playing')
      @$('.hit-button').attr('hidden',true)
      @$('.stand-button').attr('hidden',true)
      @$('.new-game-button').attr('hidden',false)
    @$('.dealer-score').html 'Dealer Score: '+@model.get 'dealerScore'
    @$('.player-score').html 'Player Score: '+@model.get 'playerScore'
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
