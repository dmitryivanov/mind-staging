class window.Dashboard.Views.ModuleList extends Backbone.View
  el: '#dashboard .modules_list'

  initialize: ->
    @listenTo(@collection, 'add', @addOne)
    @listenTo(@collection, 'reset', @addAll)
  
  addOne: (module) ->
    module_view = new window.Dashboard.Views.Module({ model: module })      
    @$el.append(module_view.render().el)

  addAll: ->
    @collection.each(@addOne, @)