Given /^I send and accept JSON$/ do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
end

Given /^I send and accept HTML$/ do
  header 'Accept', 'text/html'
  header 'Content-Type', 'text/html'
end

When(/^I send a POST request to "([^"]*)" with headers:$/) do |path, headers_table|
  headers_table.rows_hash.each {|k,v| header k, v }
  post path
end

When(/^I send a POST request to "([^"]*)"$/) do |path|
  post path
end

Then(/^the response status should be "([^"]*)"$/) do |status|
 begin
  last_response.status.should eq(status.to_i)
  rescue RSpec::Expectations::ExpectationNotMetError => e
    puts "Response body:"
    puts last_response.body
    raise e
  end
end

Then(/^the response should contain header "([^"]*)"$/) do |header|
  last_response.headers[header].should_not be nil
  # last_response.location.should_not be nil
end

Then(/^the response should be:$/) do |string|
  last_response.body.should eq string
end

Then /^show me the response body$/ do
  puts "\n\n"
  puts "===Response Body==="
  puts ""
  puts last_response.body
end
Then /^show me the response headers$/ do
  puts "\n\n"
  puts "===Response Headers==="
  puts ""
  puts last_response.headers.inspect
end
Then /^show me the response$/ do
  steps %{
    And show me the response headers
    And show me the response body
  }
end
Then /^show me the request body$/ do
  puts "\n\n"
  puts "===Request Body==="
  puts ""
  puts last_request.body
end
Then /^show me the request headers$/ do
  puts "\n\n"
  puts "===Request Headers==="
  puts ""
  puts last_request.inspect
end
Then /^show me the request$/ do
  steps %{
    And show me the request headers
    And show me the request body
  }
end
