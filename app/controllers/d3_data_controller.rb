require 'alchemyapi'
require 'net/http'


class D3DataController < ApplicationController

def d3_data

    url = Link.find(params[:id]).url
    html =  Net::HTTP.get(URI(url))
    alchemyapi = AlchemyAPI.new()
# @responseText = alchemyapi.text('url', url)


#  @responseText = alchemyapi.text('url', url)
# if @responseText['status'] == 'OK'
#   puts '## Response Object ##'
#   p @testJsonText = JSON.pretty_generate(@responseText)
#   puts ''
#   puts '## Extracted Text ##'
#   p @Texttext = 'text: ' + @responseText['text']
#   puts ''
# else
#   puts 'Error in text extraction call: ' + @responseText['statusInfo']
# end

#  @responseEntities = alchemyapi.entities('text', @Texttext, { 'sentiment'=>1 })
#   @testJsonEntities = JSON.pretty_generate(@responseEntities)

 @responseCombined = alchemyapi.combined('url', url, { 'extract'=>'page-image,keyword,entity' })
  @testJsonCombined = JSON.pretty_generate(@responseCombined)
  render(json: @testJsonCombined)

end

end
