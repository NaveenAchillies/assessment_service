require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    render_views

    context 'testing answers' do

        before(:each) do
            sign_in(User.first)
        end

        it 'without user and answers' do
            sign_out(User.first)
            post :create, {:format => 'json', :answer=>{}}
            data = JSON.parse(response.body)
            expect(response.status).to eq 401
            expect(data.keys).to match_array(["error"])
        end

        it 'without answers' do
            post :create, {:format => 'json', :answer=>{}}
            data = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(data.keys).to match_array(["error"])
        end

        it 'with random questions and submission of random anwers without skip' do
            questions = Question.limit(3).order("rand()")
            param = {}
            questions.each{|question|
            	param[question.id] = question.choices[rand(0..3)].param
            }
            post :create, {:format => 'json', :answer=>param}
            data = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(data.keys).to match_array(["success"])
        end

        it 'with random questions and submission of anwers with skip' do
            questions = Question.limit(3).order("rand()")
            param = {}
            questions.each{|question|
            	param[question.id] = 'skip'
            }
            post :create, {:format => 'json', :answer=>param}
            data = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(data.keys).to match_array(["success"])
        end

        it 'with random questions and submission of correct anwers' do
            questions = Question.limit(3).order("rand()")
            param = {}
            questions.each{|question|
            	param[question.id] = question.correct_choice.param 
            }
            post :create, {:format => 'json', :answer=>param}
            data = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(data.keys).to match_array(["success"])
        end

        after(:each) do
            sign_out(User.first)
        end
    end

end
