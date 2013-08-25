class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.min(Math.floor(card / 13),3)

  dealPlayer: -> hand = new Hand [ @pop(), @pop() ], @, false

  dealDealer: -> dealerHand = new Hand [ @pop().flip(), @pop() ], @, true