class window.Dashboard.Views.Module extends Backbone.View
  className: 'module'
  
  initialize: ->
    @listenTo(@model, 'destroy', @remove);

  events:
    'click .show' : 'editMode'

  render: ->
    unless @child_view
      show_view = new window.Dashboard.Views.ShowModule({ model: @model })
      @child_view = show_view
    
    @$el.html(@child_view.render().el)
  
    return @
  
  editMode: (e) ->   
    @child_view = new window.Dashboard.Views.EditModule({ model: @model, parentView: @ })      
    @child_view.render()
  
  remove: ->
    @child_view.remove() if @child_view
    super()