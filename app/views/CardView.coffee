class window.CardView extends Backbone.View

  className: 'container'

  tagName: 'section'

  #template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.append('<div class="card">')
    @$el.find('.card').append('<figure class="front">')
    @$el.find('.card').append('<figure class="back">')
    #@$el.html @template @model.attributes
    @$el.find('.back').attr('style',"background-image: url('lib/cards/"+@model.get('rankName')+'_of_'+@model.get('suitName')+".png')")
    #@$el.find('.card').addClass('flipped') if @model.get('revealed') and not @model.get('animateReveal')
    setTimeout  => 
     #if (@model.get('animateReveal') and @model.get 'revealed')
     if @model.get 'revealed'
      @$el.find('.card').addClass('flipped')
      @model.set 'animateReveal',false
    , 500