class window.Dashboard.Views.EditModule extends Backbone.View
  className: 'edit'
  template: HandlebarsTemplates['dashboard/edit_module']

  initialize: ->
    @parentView = @options.parentView

  events:
    'change select.dimension' : 'checkMetricDimensionValues'
    'change select.metric' : 'checkMetricDimensionValues'
  
    'change select.dimension' : 'showDimensionValuesSelector'
    'change select.module_type' : 'moduleTypeDispatcher'
  
    'change select.table' : 'showProperTableFields'

  render: ->
    self = @
  
    $(@el).html(@template(
      _.extend(
        window.Dashboard.chart_selectors_data, 
        @model.toJSON({ template: true })
      )
    ))
  
    # pupulate select with currenlty selected dimension and metric
        
    if @model.has('table')
      table = @model.get('table')
      _.each(['dimension', 'metric', 'date'], (attribute) ->
        if self.model.has(attribute)
          self.$el.find('select.'+attribute+'[data-table="'+table+'"] option[value="'+self.model.get(attribute)+'"]').
          attr('selected', 'selected')
      )
    
    @showProperCalculationFields()
    @showProperTableFields()
    @showDimensionValuesSelector()
  
    $(@el).dialog(
      autoOpen: false 
      width: 600
      height: 600
      modal: true 
      title: 'Edit module'
      draggable: false
      resizable: false
      buttons:
        "Cancel" : (e) ->
          self.exitEditMode(e)
        
        "Save" : (e) ->
          self.saveModule(e)
          self.exitEditMode(e)
        
        "Delete" : (e) ->
          self.deleteModule(e)
          self.exitEditMode(e)
    )
    $(@el).dialog( "open" )
  
    return @
  
  exitEditMode: (e) ->
    e.preventDefault() if e
    @remove()
    @parentView.render()
  
  deleteModule: (e) ->
    e.preventDefault()
    @model.destroy(
      wait: true
      success: (model, response, options) ->           
        $('<div class="flash notice">Module destroyed</div>').prependTo('#contents .row .sixteen').
          effect('highlight').fadeOut(2000, -> this.remove())

      error: (model, xhr, options) ->            
        $('<div class="flash error">>Error: can\'t destroy module</div>').prependTo('#contents .row .sixteen').
          effect('highlight').fadeOut(2000, -> this.remove())
    )
  
  saveModule: (e) ->
    e.preventDefault() if e
    table = @$el.find('select.table').val()
  
    self = @
  
    @model.save(
      { 
        notes: self.$el.find('input.notes').val()
        table: table
        module_type: self.$el.find('select.module_type').val()
        dimension_value: self.$el.find('select.dimension_value').val()
        date: self.$el.find('select.date[data-table="'+table+'"]').val()
        dimension: self.$el.find('select.dimension[data-table="'+table+'"]').val()
        metric: self.$el.find('select.metric[data-table="'+table+'"]').val()
        calculation_type: self.$el.find('select.calculation_type').val()
      }
      {
        wait: true,
        success: (model, response, options) ->           
          $('<div class="flash notice">Module saved</div>').prependTo('#contents .row .sixteen').
            effect('highlight').fadeOut(2000, -> this.remove())
          self.exitEditMode()

        error: (model, xhr, options) ->            
          $('<div class="flash error">>Error: can\'t save module</div>').prependTo('#contents .row .sixteen').
            effect('highlight').fadeOut(2000, -> this.remove())
      }
    )
    
  moduleTypeDispatcher: (e) ->
    @showDimensionValuesSelector(e)
    @showProperCalculationFields(e)
  
  showProperCalculationFields: (e) ->
    $calculation_selector = @$el.find('div.select_calculation_type')
    if @$el.find('select.module_type').val() == 'trend_chart'
      $calculation_selector.show()
    else
      $calculation_selector.hide()
  
  showProperTableFields: (e) ->
    # hide all metrics and dimensions
    @$el.find('div.metric, div.dimension, div.date').hide()
  
    # show metric and dimension for currently selected table
    table = @$el.find('select.table:first').val()
    @$el.find("div[data-table='"+table+"']").show() unless table == ''
    
  
  checkMetricDimensionValues: (e) ->
    this_selector = $(e.target)
    unless this_selector.val() == ''
      other_selector_type = ( if this_selector.hasClass('dimension') then 'metric' else 'dimension')
      this_value = this_selector.val()
      table = this_selector.data('table')
      other_selector = $('select.'+other_selector_type+'[data-table="'+table+'"]')
      other_value = other_selector.val()
    
      if this_value == other_value
        other_selector.find('option[selected="selected"]:first').removeAttr('selected')
        other_selector.find('option[value=""]:first').attr('selected', 'selected')
      
  showDimensionValuesSelector: (e) ->
    $(@el).find('div.select_dimension_value').hide()
    $(@el).find('div.date').hide()
  
    this_selector = $(@el).find('select.module_type')
    return true if this_selector.val() != 'trend_chart'

    table = $(@el).find('select.table').val()
    return true if table == ''

    dimension_selector = $(@el).find('select.dimension[data-table="'+table+'"]')
    dimension = dimension_selector.val()
    return true if dimension == ''
  
    $(@el).find('div.select_dimension_value .preloader').css('display', 'inline')
    $(@el).find('select.dimension_value').hide()
    $(@el).find('select.dimension_value').html('')
    $(@el).find('div.select_dimension_value').show()
    $(@el).find('div.date[data-table="'+table+'"]').show()
  
    self = @
    $.get(
      '/dashboards/'+@model.get('dashboard_id')+'/dashboard_modules/dimension_values', 
      { table: table, dimension: dimension },
      (data, status, xhr) ->
        _.each(data, (item) ->
          if item.value != null and self.model.has('dimension_value') and item.value.toString() == self.model.get('dimension_value').toString()
            selected = 'selected="selected" '
          else
            selected = ''
          
          $(self.el).find('select.dimension_value').append('<option '+selected+'value="'+item.value+'">'+item.name+'</option>')
        )
      
        $(self.el).find('select.dimension_value').prepend('<option value=""></option>')
        $(self.el).find('select.dimension_value').show()
        $(self.el).find('div.select_dimension_value .preloader').hide()
      ,
      'json'
    )
  
  
    
  remove: ->
    delete @parentView.child_view
    super()