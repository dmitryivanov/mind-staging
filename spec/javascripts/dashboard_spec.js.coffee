#= require ../../app/assets/javascripts/dashboard

describe "Dashboard", ->
  
  beforeEach ->
    @dashboard_options = getJSONFixture('dashboard_options')
    window.Dashboard.init(@dashboard_options)
    
  it "should load fixture", ->
    expect(@dashboard_options).toBeDefined()
    expect(@dashboard_options).not.toEqual({})
    
    
  describe "module edit view", ->
    
    beforeEach ->
      @model = new window.Dashboard.Models.Module(@dashboard_options.dashboard_modules[0])
      @view = new window.Dashboard.Views.EditModule({ model: @model })
      @view.render()      
      
    it "should create a div element", ->
      expect(@view.el.nodeName).toEqual("DIV");
    
    it "tries to save model when save button clicked", ->    
      spyOn(@model, 'save')
      @view.saveModule()
      expect(@model.save).toHaveBeenCalled()
      
    it "should render edit form", ->
      expect(@view.el).toBeDefined()
      expect(@view.el).toHaveClass('edit')
      
    it "should set calculation_type to a corresponding module attribute", ->
      options = @dashboard_options.dashboard_modules[0]
      options.calculation_type = 'count'
      model = new window.Dashboard.Models.Module(options)
      view = new window.Dashboard.Views.EditModule({ model: model })
      view.render()
      expect(view.$el.find('select.calculation_type').val()).toEqual('count')
      
      
    describe "when trend chart is not selected", ->
      
      it "should contain hidden calculation type selector", ->
        expect(@view.$el.find('select.module_type').val()).toEqual('')
        expect(@view.$el.find('select.calculation_type')).toBeHidden()
        
        
        
      
    describe "when trend chart is selected", ->
    
      beforeEach ->
        @view.$el.find('select.module_type').val('trend_chart').trigger('change') 
    
      it "should show calculation type selector", ->
        expect(@view.$el.find('select.calculation_type')).toBeVisible()

        
    describe "when saving module", ->
      
      it "should save selected calculation type", ->
        
        @view.$el.find('select.calculation_type').val('count')
        spyOn(@model, 'save')
        @view.saveModule()
        expect(@model.save.mostRecentCall.args[0].calculation_type).toEqual('count')
        