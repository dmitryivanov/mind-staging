describe "DataloadGa", ->
  
  # TODO:
  #
  # - save selected profile and account as dataload attributes
  #
  # - let the user to choose arbitrary metric and dimesions (multiple values)
  #
  # - try to create a query to GA and return error if there will be an error on GA part,
  #    e.g. ILLEGAL QUERY error message
  
  # metrics and dimensions should be defined as constants, and ga_dataload should have_many dimensions
  # and metrics
  
  ###
  
  it will be better to use multi-step form, wich will function without js in this way:
  
  1) go to new action
  
  2) input credentials and press next
  
------------------> HERE
  
  3) validate credentials, load and cahce profiles and acounts. show response.
     credentials validation should definately be background
  
  4) if credentials are valid, show accounts selector
  
  5) when account selected, press next to see profile selector
  
  # 6) when profile selected, press next to add metrics and dimensions
  # 
  # 7) by default there will be no metrics and dimensionsm but there will be has_many association.
  # we will also add empty selectors, so when they are not blank association will be created.
  # to add metric or dimension we will press corresponding 'add button' - this somehow show one more
  # selector, preserving all other values - probably we will have to update form.
  # 
  # 8) when pressed, selector will be added after a post - e.g. 
  
  also, when moving from step to step browser url should also updated.
  when we reload page it should render same thing
  
  ###
  
  # beforeEach ->
  #   loadFixtures "dataload_ga_form"  
  # 
  # it "triggers account change on document load"
  # 
  # describe "on form submit", ->
  #   
  #   it "appends profile selector value for selected account to form", ->
  #     
  #     $('select#dataload_ga_ga_account_id').val('1445323').change()
  #     $('.profile_selector[rel=1445323]').val('16550641').change()
  #     
  #     form_selector = 'form.edit_dataload_ga'
  #     spy_event = spyOnEvent(form_selector, 'submit')
  #     $('input[name=commit]').trigger("click")
  #     expect(spy_event).toHaveBeenTriggered()
  # 
  # describe "on account selector change", ->
  # 
  #   it "shows proper profiles selector when account is selected", ->
  #   
  #     $('select#dataload_ga_ga_account_id').val('1445323').change()
  #     expect($('.profile_container[rel=1445323]')).toBeVisible()
  #   
  #   it "resets profile selector when account is changed", ->
  #   
  #     $('.profile_selector[rel=1445323]').val('16550641')
  #     $('select#dataload_ga_ga_account_id').val('1445323').change()
  #     expect($('.profile_selector[rel=1445323]').val()).toBe('')
  #   
  #   it "hides profiles selectors of other accounts", ->
  #   
  #     $('select#dataload_ga_ga_account_id').val('1445323').change()
  #     expect($('.profile_container[rel=1445323]')).toBeVisible()
  #     expect($('.profile_container[rel=1241412]')).toBeHidden()
  #   
  #     $('select#dataload_ga_ga_account_id').val('1241412').change()
  #   
  #     expect($('.profile_container[rel=1445323]')).toBeHidden()
  #     expect($('.profile_container[rel=1241412]')).toBeVisible()
  #   
  # it "shows pro"
  # 
  # it "shows dimensions selector when profile is selected"
  # 
  # it "resets dimensions selector when other profile is selected"
  # 
  # it "shows proper metrics selector when dimension is selected"
  # 
  # it "resets mietrics selector when other dimension is selected"
  # 
  # it "submits proper profile, dimension and metric"
  # 
  
  #     
  #     # when account is selected then profile selector for this account
  #     # should appear
  #     
  #     # when form is submitted profile id of that account should be submitted
  #     
  #     loadFixtures "dataload_ga_form"
  #     
  #     $('#dataload_ga_ga_account_id').val('1445323')
  #     
  #     expect(
  #       $('#dataload_ga_ga_account_id').val()
  #     ).toEqual('1445323');
  #     