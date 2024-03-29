class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> 
    limit = if @isDealer then 17 else 22
    if @scores() <= limit
      @add(@deck.pop()).last() 
      addedCard = true
    @trigger 'busted' if @scores() > 21 && addedCard
    @trigger 'stand' if @scores() is 21
    @last

  dealerHit: ->
    @hit() until @scores() >= 17
    if @scores() > 21 
    then @trigger 'dealerBust' 
    else @trigger 'dealerDone'

  # Trigger standing event to App to have the deal make its moves
  stand: -> @trigger 'stand'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce && score+10<21 then score else score
