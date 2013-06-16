class window.Dashboard.Models.Module extends Backbone.Model
  urlRoot: ->
    return '/dashboards/'+window.Dashboard.current_dashboard.id+'/dashboard_modules'
    
  isBarChart: ->
    return @get('module_type') == 'bar_chart'
  
  toJSON: (options) ->
    if ((options != undefined) && options.template == true)
      
      # http://stackoverflow.com/questions/10648990/how-to-access-a-calculated-field-of-a-backbone-model-from-handlebars-template
      json = _.clone(this.attributes)
      json.isBarChart = @isBarChart()
      return json
      
    else
      return { dashboard_module: _.clone( this.attributes ) }