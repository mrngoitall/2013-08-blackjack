class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: -> 
    @render()
    @model.on('busted', @busted)
    @model.on('dealerbust', @dealerbust)
    @model.on('playerwins', @playerwins)
    @model.on('dealerwins', @dealerwins)


  busted: -> alert 'Busted, dealer wins!'

  dealerbust: -> alert 'Dealer busted; you win!'

  playerwins: -> alert 'You win!'

  dealerwins: -> alert 'Dealer wins!'

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
