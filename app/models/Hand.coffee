class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on('busted', @busted)

  hit: -> 
    limit = if @isDealer then 17 else 20
    if @scores()[0] <= limit
      @add(@deck.pop()).last() 
      addedCard = true
    @trigger 'busted' if @scores()[0] > 21 && addedCard

  dealerHit: ->
    @hit() until @scores()[0] >= 17
    if @scores()[0] > 21 
    then @trigger 'dealerbust' 
    else @trigger 'dealerdone'

  # Trigger standing event to App to have the deal make its moves
  stand: -> @trigger 'standing'

  busted: -> 

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
    if hasAce && score+10<21 then [score + 10] else [score]
