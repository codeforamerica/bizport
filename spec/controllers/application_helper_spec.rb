require 'rails_helper'

describe ApplicationHelper do
  describe '#next_step_page_service' do

    it 'should return the correct next page title' do
      request = OpenStruct.new( { path: '/plan/get-idea' } )
      expect(ApplicationHelper.next_step_page_service('title', request)).to eq('Next: Support Options')

      request = OpenStruct.new( { path: '/grow/business-taxes' } )
      expect(ApplicationHelper.next_step_page_service('title', request)).to eq('Next: Obtain Funding')

      request = OpenStruct.new( { path: '/apply/plan-check' } )
      expect(ApplicationHelper.next_step_page_service('title', request)).to eq('Next: Permits')
    end

    xit 'should return the correct next page path' do

    end
  end
end
