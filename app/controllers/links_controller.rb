require 'alchemyapi'
require 'net/http'
require 'betaface'
api = Betaface::Api.new("d45fd466-51e2-4701-8da8-04351c872236","171e8465-f548-401d-b63b-caf0dc28df5f")



class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    url = Link.find(params[:id]).url
    html =  Net::HTTP.get(URI(url))
    alchemyapi = AlchemyAPI.new()
@responseText = alchemyapi.text('url', url)

 @responseText = alchemyapi.text('url', url)
if @responseText['status'] == 'OK'
  puts '## Response Object ##'
  p @testJsonText = JSON.pretty_generate(@responseText)
  puts ''
  puts '## Extracted Text ##'
  p @Texttext = 'text: ' + @responseText['text']
  puts ''
else
  puts 'Error in text extraction call: ' + @responseText['statusInfo']
end

#################


    
    @responseEntities = alchemyapi.entities('text', @Texttext, { 'sentiment'=>1 })
    @testJsonEntities = JSON.pretty_generate(@responseEntities)

    @responseConcepts = alchemyapi.concepts('text', @Texttext)
    @testJsonConcepts = JSON.pretty_generate(@responseConcepts)


puts 'Processing html: ' 
puts ''
  @responseSentiment = alchemyapi.sentiment('html', html)
if @responseSentiment['status'] == 'OK'
  puts '## Response Object ##'
@testJsonSentiment = JSON.pretty_generate(@responseSentiment)
  puts ''
  puts '## Document Sentiment ##'
  @sentiment_type = 'type: ' + @responseSentiment['docSentiment']['type']
  #Make sure score exists (it's not returned for neutral sentiment
  if @responseSentiment['docSentiment'].key?('score')
  @sentiment_score = 'score: ' + @responseSentiment['docSentiment']['score']
  end
else
  puts 'Error in sentiment analysis call: ' + @responseSentiment['statusInfo']
end




    # @responseSentimentTargeted = alchemyapi.sentiment_targeted('text', @responseSentiment, 'dev'  )
    # @testJsonSentimentTargeted = JSON.pretty_generate(@responseSentimentTargeted)
    # @final_targeted_sentiment = @responseSentimentTargeted['docSentiment']['type']

    @responseAuthor = alchemyapi.author('url', url)
    @testJsonAuthor = JSON.pretty_generate(@responseAuthor)

    @responseLanguage = alchemyapi.language('text', @Texttext)
    @testresponseLanguage = JSON.pretty_generate(@responseLanguage)

    @responseTitle = alchemyapi.title('url', url)
    @testJsonTitle = JSON.pretty_generate(@responseTitle)


    @responseRelations = alchemyapi.relations('text', @Texttext)
    @testJsonRelations = JSON.pretty_generate(@responseRelations)

    @responseCategory = alchemyapi.category('text',@Texttext)
    @testJsonCategory = JSON.pretty_generate(@responseCategory)


    @responseFeed = alchemyapi.feeds('url', url)
    @testJsonFeed = JSON.pretty_generate( @responseFeed)

    @responseMicroformat = alchemyapi.microformats('url', url)
    @testJsonMicroformat = JSON.pretty_generate(@responseMicroformat)


    @responseTaxonomy = alchemyapi.taxonomy('url', url)
    @testJsonTaxonomy = JSON.pretty_generate(@responseTaxonomy)

    @responseImag = alchemyapi.image_extract('url', url, { 'extractMode'=>'trust-metadata' })
    @testJsonImg = JSON.pretty_generate(@responseImag)


    @responseCombined = alchemyapi.combined('url', url, { 'extract'=>'page-image,keyword,entity' })
    @testJsonCombined = JSON.pretty_generate(@responseCombined)

    @responseImage_tag = alchemyapi.image_tag('url', url, { 'extractMode'=>'trust-metadata' })
    @testJsonImage_tag = JSON.pretty_generate(@responseImage_tag)

   
p 'ksksks'
p #@responseImage_tag.body
p 'ksksks'

@responseKeyword = alchemyapi.keywords('text', @Texttext, { 'sentiment'=>1 })

  if @responseKeyword['status'] == 'OK'
  @object = '## Response Object ##'
  @testJsonKey = JSON.pretty_generate(@responseKeyword)

  @string = ''
  puts '## Keywords ##'
  for keyword in @responseKeyword['keywords']
    @text = 'text: ' + keyword['text']
    @relevance = 'relevance: ' + keyword['relevance']
    @sentiment = 'sentiment: ' + keyword['sentiment']['type'] 
    

    #Make sure score exists (it's not returned for neutral sentiment
    if keyword['sentiment'].key?('score')
      print ' (' + keyword['sentiment']['score'] + ')'
    end
    puts ''
  end
else
  puts 'Error in keyword extraction call: ' + @responseKeyword['statusInfo']
end
p '12345678'
p img = @responseImage_tag["url"]
api = Betaface::Api.new("d45fd466-51e2-4701-8da8-04351c872236","171e8465-f548-401d-b63b-caf0dc28df5f")
p urlimg = api.upload_image("propoints,classifiers",{url: img})
p"12345"
p img_id = urlimg["img_uid"]
p"cec"
p api.get_image_info(img_id)

  end

######################################################################################
######################################################################################
######################################################################################
  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create

    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def analyze
    @link = Link.find(params[:id])
    #html =  Net::HTTP.get(URI(url))
    alchemyapi   = AlchemyAPI.new()
    responseText = alchemyapi.text('url', @link.url)

@data = alchemyapi.entities('text', responseText, { 'sentiment'=>1 })["entities"].select{|c| c["sentiment"] }.map{|c| { type: c["type"], title: c["text"], subtype: c["disambiguated"] ? c["disambiguated"]["subType"] : "", website: c["disambiguated"] ? c["disambiguated"]["website"] : "", dbpedia: c["disambiguated"] ? c["disambiguated"]["dbpedia"] : "",freebase: c["disambiguated"] ? c["disambiguated"]["freebase"] : "",yago: c["disambiguated"] ? c["disambiguated"]["yago"] : "", relevance: sprintf('%.2f',c["relevance"]), score: c["sentiment"]["score"].to_f.round(1), count: c["count"].to_i } }.sort_by {|c| -c[:score] }

# format the entities data into:

# {
#   type: "Person",
#   title: "Jeff Fisher",
#   relevance: 0.79562,
#   score: -0.383586,
#   count: 4
# }
  @responseTaxonomy = alchemyapi.taxonomy('url', @link.url)["taxonomy"].select{|c| c["label"]}.map{|c| {type: c["label"], score: c["score"].to_f.round(1) } }
    @testJsonTaxonomy = JSON.pretty_generate(@responseTaxonomy)




  respond_to do |format|
    format.html
    format.js
  end 
  end

  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_from current_user
    redirect_to :back
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url)
    end
end
