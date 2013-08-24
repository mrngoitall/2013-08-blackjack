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
    if !@model.get('playing')
      @$('.hit-button').attr('hidden',true)
      @$('.stand-button').attr('hidden',true)
      @$('.new-game-button').attr('hidden',false)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
