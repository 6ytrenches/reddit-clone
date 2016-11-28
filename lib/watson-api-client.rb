require 'watson-api-client'

puts WatsonAPIClient::AvailableAPIs


service = WatsonAPIClient::PersonalityInsights.new(:user=>"422589bd-5a90-4ac9-b858-eca78147fec6",
                                                   :password=>"TmJQkAA0hwcV",
                                                   :verify_ssl=>OpenSSL::SSL::VERIFY_NONE)
result = service.profile(
  'Content-Type'     => "text/plain",
  'Accept'           => "application/json",
  'Accept-Language'  => "en",
  'Content-Language' => "en",
  'body'             => open('https://raw.githubusercontent.com/suchowan/watson-api-client/master/LICENSE',
                             :ssl_verify_mode=>OpenSSL::SSL::VERIFY_NONE))
p JSON.parse(result.body)


