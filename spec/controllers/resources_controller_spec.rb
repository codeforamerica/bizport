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
    it 'should accept a GET for an existing search result' do
      allow_any_instance_of(ResourcesController).to receive(:api_response_for).and_return({
        'id' => 1,
        'results' => [],
        'purposes' => [],
        'created_at' => '2016-07-08T21:17:39.210313Z',
        'updated_at' => '2016-07-08T21:17:39.210348Z',
        'city' => 'Long Beach',
        'state' => 'CA',
        'personal_investment' => true,
        'existing_business' => 'new',
        'small_business' => true,
        'view_count' => 1,
        'industry' => nil
      })
      get :results, id: 999_999
      expect(response).to render_template(:results)
    end

    it 'should 404 when it receives a GET for a non-existent search result' do
      expect{
        get :results, id: 999_999
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#show' do
    it 'should return details for an existing resource' do
      allow_any_instance_of(ResourcesController).to receive(:api_response_for).and_return({
        'id' => 1,
        'created_at' => '2016-07-12T22:48:34.296731Z',
        'updated_at' => '2016-07-12T22:48:34.296757Z',
        'city' => 'Long Beach',
        'state' => 'CA',
        'personal_investment' => false,
        'existing_business' => nil,
        'small_business' => false,
        'title' => 'Hire Manufacturing People',
        'industries' => [
          {
            'id' => 1,
            'created_at' => '2016-07-12T22:48:12.651401Z',
            'updated_at' => '2016-07-12T22:48:12.651429Z',
            'name' => 'Manufacturing',
            'order' => 1,
            'creator' => 1
          }
        ],
        'purposes' => [
          {
            'id' => 1,
            'created_at' => '2016-07-12T22:48:25.006707Z',
            'updated_at' => '2016-07-12T22:48:25.006738Z',
            'name' => 'Hiring',
            'order' => 1,
            'creator' => 1
          }
        ],
      })
      get :show, id: 999_999
      expect(response).to have_http_status(200)
    end

    it 'should 404 for a non-existent resource' do
      expect{
        get :show, id: 999_999
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end