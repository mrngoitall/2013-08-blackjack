class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
      <button class="new-game-button">New Game</button>
    <div class="player-status"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> @newGame()

  initialize: -> 
    @render()
    @model.on 'gameOver', @render, @

  newGame: ->
    @model.trigger 'newGame'
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-status').html @model.get 'status'
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
