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
    it 'should redirect to /results after a POST with valid search params' do
      allow_any_instance_of(ResourcesController).to receive(:api_response_for)
        .with(anything, 'POST', anything)
        .and_return({'id' => 1})
      post :search # no need for params - we'll just pretend this works

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(/\/resources\/search\/\d+/)
    end
  end

  describe '#results' do
    it 'should accept a GET for an existing search result' do
      allow_any_instance_of(ResourcesController)
        .to receive(:api_response_for)
      get :results, id: 999_999
      expect(response).to render_template(:results)
    end

    it 'should 404 when it receives a GET for a non-existent search result' do
      expect do
        get :results, id: 999_999
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#show' do
    it 'should return details for an existing resource' do
      allow_any_instance_of(ResourcesController)
        .to receive(:api_response_for)
      get :show, id: 999_999
      expect(response).to have_http_status(200)
    end

    it 'should 404 for a non-existent resource' do
      expect do
        get :show, id: 999_999
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
