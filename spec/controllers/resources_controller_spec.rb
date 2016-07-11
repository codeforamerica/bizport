require 'rails_helper'

describe ResourcesController do
  describe '#new' do
    it 'should return a template with a form' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe '#search' do
    xit 'should redirect to /results after a POST with valid search params' do
      search_params = {
        city: 'Long Beach',
        state: 'CA',
      }
      post :search, search_params

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(resources_search_path(assigns(:search_data).id))
    end
  end

  describe '#results' do
    xit 'should accept a GET for an existing search result' do
      get :results, id: 1
      expect(response).to render_template(:results)
    end

    it 'should 404 when it receives a GET for a non-existent search result' do
      expect{
        get :results, id: 99999
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#show' do
    xit 'should return details for an existing resource' do
      get :show, id: 1
      expect(response).to have_http_status(200)
    end

    it 'should 404 for a non-existent resource' do
      expect{
        get :show, id: 99999
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end