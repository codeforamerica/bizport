class ResourcesController < ApplicationController
  require 'net/http'

  API_URL = 'https://longbeachresources.tk/wm-api/'

  def new
    industries_url = URI.parse(API_URL + 'industry/')
    purposes_url = URI.parse(API_URL + 'purpose/')

    @industries = api_response_for(industries_url)
      .map{ |industry| { id: industry["id"], name: industry["name"] } }
    @purposes = api_response_for(purposes_url)
      .map{ |purpose| { id: purpose["id"], name: purpose["name"] } }
  end

  # POST
  def search
    url = URI.parse(API_URL + 'search/')

    response = api_response_for(url, 'POST', api_params(params))
    @api_response = JSON.parse(response.body)

    redirect_to '/resources/search/' + @api_response['id'].to_s
  end

  def results
    search_id = params[:id]
    url = URI.parse(API_URL + 'search/' + search_id + '/')

    @search_data = api_response_for(url)
  end

  def show
    opportunity_id = params[:id]
    url = URI.parse(API_URL + 'opportunity/' + opportunity_id + '/')

    @opportunity = api_response_for(url)
  end


  private

  def api_response_for(url, method='GET', params={})
    if method == 'POST'
      return Net::HTTP.post_form(url, params)
    else
      res = Net::HTTP.get_response(url)
      if res.code == '404'
        raise ActiveRecord::RecordNotFound
      end

      return JSON.parse(res.body)
    end
  end

  def api_params(params)
    valid_params = [
      'city',
      'state',
      'industry',
      'purposes',
      'personal_investment',
      'small_business',
    ]

    params.select{ |p| valid_params.include? p }
  end

end
