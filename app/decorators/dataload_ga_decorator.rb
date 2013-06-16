class DataloadGaDecorator < Draper::Decorator
  decorates :dataload_ga
  delegate_all
  
  def hidden_profile_select_for_account(account)
    
    
    profiles = model.profiles.select{ |p| p.account_id == account.id }
    profiles = profiles.collect{|p| [ p.name, p.id ] }
    options = h.options_for_select(profiles, model.ga_profile_id)
    
    output = h.content_tag :div,
      :rel => account.id,
      :class => "profile_container",
      :style => 'display:none' do
        
        h.label_tag('Profile')
        h.select_tag(
          "profile_selector", 
          options, 
          :include_blank => true, 
          :class => 'profile_selector',
          :rel => account.id,
          :id => nil
        )
    
    end
    
    return output.html_safe
  end
end