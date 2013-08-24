class window.CardView extends Backbone.View

  className: 'card'

  #template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    #@$el.html @template @model.attributes
    @$el.attr('style',"background-image: url('lib/cards/"+@model.get('rankName')+'_of_'+@model.get('suitName')+".png')") if @model.get 'revealed'
