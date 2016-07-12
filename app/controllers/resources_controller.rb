class ResourcesController < ApplicationController
  require 'net/http'

  API_URL = 'http://52.53.197.246/wm-api/'

  def new
  end

  # POST
  def search
    search_params = params
    url = URI.parse(API_URL + 'search/')

    @api_response = api_response_for(url, 'POST', params)

    redirect_to '/resources/search/'+@api_response['id'].to_s
  end

  def results
    search_id = params[:id]
    url = URI.parse(API_URL+'search/'+search_id+'/')

    @search_data = api_response_for(url)
  end

  def show
    opportunity_id = params[:id]
    url = URI.parse(API_URL+'opportunity/'+opportunity_id+'/')

    @opportunity = api_response_for(url)
  end


  private

  def api_response_for(url, method='GET', params={})
    if method == 'POST'
      return Net::HTTP.post_form(url, params)
    else
      res = Net::HTTP.get_response(url)
      if res.code == "404"
        raise ActiveRecord::RecordNotFound
      end

      return JSON.parse(res.body)
    end
  end

end
