require 'rails_helper'

RSpec.describe ExamsController, type: :controller do
    render_views
    before(:each) do
            sign_in(User.first)
    end
    context 'exam' do
        it 'check with _user' do
            get :index, {:format => 'json'}
            expect(response.status).to eq 200
        end

        it 'check without user' do
            sign_out(User.first)
            get :index, {:format => 'json'}
            expect(response.status).to eq 401
        end

        it "get user answer percentages and unseen questions" do
            get :get_details, {:format => 'json'}
            expect(response.status).to eq 200
            data = JSON.parse(response.body)
            expect(data.keys).to match_array(["unseen", "percentage"])
            expect(data['unseen'].keys).to match_array(["chapters", "topic", "subject", "exam"])
            expect(data['percentage'].keys).to include("correct", "wrong")
        end
    end

    after(:each) do
        sign_out(User.first)
    end

end
