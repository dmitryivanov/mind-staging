class window.Dashboard.Views.ShowModule extends Backbone.View
  className: 'show'
  
  placeholder_template: HandlebarsTemplates['dashboard/show_module_placeholder']
  chart_template: HandlebarsTemplates['dashboard/show_module_chart']

  render: ->
    if @model.has('data') && @model.get('data').length > 0
    
      $(@el).html @chart_template(@model.toJSON({ template: true }))
    
      if @model.get('module_type') == 'bar_chart'
        window.bar_chart(460, 220, @model.get('data'), @$el.find('.chart')[0])
      else if @model.get('module_type') == 'trend_chart'
        window.trend_chart(460, 220, @model.get('data'), @$el.find('.chart')[0])
      
    else
    
      $(@el).html @placeholder_template(@model.toJSON({ template: true }))
    
      Holder.run({
          images: @$el.find('img.holder').first()[0]
      })
  
    return @
  
