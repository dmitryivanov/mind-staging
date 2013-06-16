window.Dashboard =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
  init: (options) ->
    
    ##
    ## Preload current dashboard attributes and render dashboard details view
    ##
    
    console.log(options)
    
    @current_dashboard = new @Models.Dashboard(options.dashboard_data)
    
    @dashboard_details_view = new @Views.DashboardDetails({ 
      model: @current_dashboard
    })
    
    @dashboard_details_view.render()
    
    ##
    ## Load module list view, then reset it with preloaded modules
    ##
    
    @current_modules = new @Collections.Modules    
    @module_list_view = new @Views.ModuleList({ collection: @current_modules })
    
    if options.dashboard_modules and options.dashboard_modules.length > 0      
      @current_modules.reset(options.dashboard_modules)
      
    @chart_selectors_data = options.chart_selectors_data
  
    
    