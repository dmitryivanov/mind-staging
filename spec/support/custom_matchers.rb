# http://stackoverflow.com/questions/6729134/how-to-assert-number-of-elements-using-capybara-with-proper-error-message

RSpec::Matchers.define :match_exactly do |expected_match_count, selector|
    match do |context|
        matching = context.all(selector)
        @matched = matching.size
        @matched == expected_match_count
    end

    failure_message_for_should do
        "expected '#{selector}' to match exactly #{expected_match_count} elements, but matched #{@matched}"
    end

    failure_message_for_should_not do
        "expected '#{selector}' to NOT match exactly #{expected_match_count} elements, but it did"
    end
end