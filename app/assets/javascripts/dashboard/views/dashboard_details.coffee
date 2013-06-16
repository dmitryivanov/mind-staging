class window.Dashboard.Views.DashboardDetails extends Backbone.View
  el: '#dashboard .details'
  template: HandlebarsTemplates['dashboard/details']

  events:
    'click span.editable' : 'makeEditable',
    'focusout input.editable-attribute' : 'saveEditable',
    'keypress input.editable-attribute' : 'saveEditableOnkey',
    'click button.add_module' : 'addModule'

  render: ->
    $(@el).append @template(@model.toJSON({ template: true}))      
  
    return @

  makeEditable: (e) ->
    input = '<input type="text" value="'+$(e.target).text()+'" class="editable-attribute"/>'
    $(e.target).html('')
    $(input).appendTo($(e.target)).focus()

  saveEditableOnkey: (e) ->
    if (e.keyCode == 13)
      e.target.blur()
  
  saveEditable: (e) ->
    value = $(e.target).val()
    span = $(e.target).closest('span.editable')
    self = @
    attributes = {}
    attribute_name = span.data('attribute-name')
    attributes[attribute_name] = value
  
    @model.save(
      attributes,
      {
        wait: true,
        success: (model, response, options) ->
          span.html(value).effect('highlight')

        error: (model, xhr, options) ->
          span.append('<span class="error">Error: can\'t save dataload</span>')
      }
    )
  
    e.preventDefault()
  
  addModule: ->
    module = new window.Dashboard.Models.Module
    module.save({},
      {
        wait: true,
        success: (model, response, options) ->
          window.Dashboard.current_modules.add(module)            
          $('<div class="flash notice">Module added</div>').prependTo('#contents .row .sixteen').
            effect('highlight').fadeOut(2000, -> this.remove())

        error: (model, xhr, options) ->            
          $('<div class="flash error">>Error: can\'t add module</div>').prependTo('#contents .row .sixteen').
            effect('highlight').fadeOut(2000, -> this.remove())
      }
    )
