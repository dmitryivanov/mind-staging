class window.Dashboard.Models.Dashboard extends Backbone.Model
  urlRoot: '/dashboards'
  
  toJSON: (options) ->
    if ((options != undefined) && options.template == true)
      return _.clone(this.attributes)
    else
      return { dashboard: _.clone( this.attributes ) }
