RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
 
  # Make helpers, including link helpers, work with Draper in specs.
  # https://github.com/jcasimir/draper/pull/49#issuecomment-4003191
  # NOTE: You may need to change ":all" to ":each" for this to work. See Gist comments.
  config.before(:all, :draper_with_helpers) do
    c = ApplicationController.new
    c.request = ActionDispatch::TestRequest.new
    Draper::ViewContext.current = c.view_context
  end
end