class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  def get_details
    @resp = {}
    user_data = Question.joins("left join answers on answers.question_id = questions.id and answers.user_id = #{current_user.id}").joins({:chapter=>{:topic=>{:subject=>:exam}}}).where(:answers=>{:id=>nil}).group("chapters.id, topics.id, subjects.id, exams.id").select("count(questions.id) cnt, chapters.id chapters, topics.id topic, subjects.id subject, exams.id exam").as_json
    user_data.each{|data|
      data.each{|key,val|
        next if ["id","cnt"].include?(key)
        @resp[key] ||={}
        @resp[key][data[key.to_s]] ||= 0
        @resp[key][data[key.to_s]] += data["cnt"]
      }
    }
    @total_percent = current_user.total_percent.as_json
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.fetch(:exam, {})
    end
end