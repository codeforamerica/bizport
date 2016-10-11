class ResourcesController < ApplicationController
  require 'net/http'

  API_URL = 'https://longbeach-resources.herokuapp.com/wm-api/'

  def new
    benefit_types_url = URI.parse(API_URL + 'benefit-type/')
    industries_url = URI.parse(API_URL + 'industry/')
    purposes_url = URI.parse(API_URL + 'purpose/')

    @benefit_types = api_response_for(benefit_types_url)
      .map { |benefit_type| { id: benefit_type["id"], name: benefit_type["name"] } }
    @industries = api_response_for(industries_url)
      .map { |industry| { id: industry["id"], name: industry["name"] } }
    @purposes = api_response_for(purposes_url)
      .map { |purpose| { id: purpose["id"], name: purpose["name"] } }
  end

  # POST
  def search
    url = URI.parse(API_URL + 'search/')

    @api_response = api_response_for(url, 'POST', api_params(params))
    if @api_response['id']
      redirect_to '/resources/search/' + @api_response['id'].to_s
    else
      redirect_to '/resources/search/', flash: @api_response
    end
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
      res = Net::HTTP.post_form(url, params)
    else
      res = Net::HTTP.get_response(url)
      if res.code == '404'
        raise ActiveRecord::RecordNotFound
      end

    end

    return JSON.parse(res.body)
  end

  def api_params(params)
    valid_params = [
      'city',
      'state',
      'benefit_types',
      'industries',
      'purposes',
      'personal_investment',
      'small_business'
    ]

    validated_params = params.select { |p| valid_params.include? p }

    cleaned_params = validated_params.tap do |vp|
      if vp['purposes']
        vp['purposes'] = vp['purposes'].reject { |p| p == 'Other' }
      end
    end

    cleaned_params
  end

end
