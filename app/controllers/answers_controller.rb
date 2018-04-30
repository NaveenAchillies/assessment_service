class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    formed_params = []
    answer_params.each{|question_id,option|
      if option == Question.find(question_id).correct_choice.param
        status = Answer.statuses['correct']
      elsif option == "skip"
        status = Answer.statuses['skip']  
      else
        status = Answer.statuses['wrong']
      end
      formed_params << {:option=>option, :status=>status, :question_id=>question_id, :user_id=>current_user.id}
    }
    answers = Answer.create(formed_params)
    respond_to do |format|
      if answers.pluck(:id).compact.present?
        format.html { redirect_to '/', notice: 'Answers Submitted.' }
        format.json { render json: {success: 'Answers Submitted.'} }
      else
        format.html { redirect_to '/', notice: 'Failed' }
        format.json { render json: {error: 'Failed.'} }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.fetch(:answer, {})
    end
end
