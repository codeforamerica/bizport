class ResourcesController < ApplicationController
  require 'net/http'

  API_URL = 'http://54.153.4.226/wm-api/'

  def new
  end

  # POST
  def search
    search_params = params
    url = URI.parse(API_URL + 'search/')
    res = Net::HTTP.post_form(url, params)
    @api_response = JSON.parse(res.body)

    redirect_to '/resources/search/'+@api_response['id'].to_s
  end

  def results
    search_id = params[:id]
    url = URI.parse(API_URL+'search/'+search_id+'/')
    res = Net::HTTP.get_response(url)
    @results = JSON.parse(res.body)
  end

  def show
    opportunity_id = params[:id]
    url = URI.parse(API_URL+'opportunity/'+opportunity_id+'/')
    res = Net::HTTP.get_response(url)
    @opportunity = JSON.parse(res.body)
  end

end
