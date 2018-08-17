class AnswerController < ApplicationController
  before_action :check_mode, :only => [:index]
  skip_before_action :verify_authenticity_token, :only => [:update]

  def index
    @challenge = Challenge.find(params[:challenge_id])
  end

  def create
    @challenge = Challenge.find(params[:challenge_id])
    @answer = @challenge.answers.build(answer_params)

    if @answer.valid?
      @answer.save
      flash[:success] = "Your answer saved!"
      redirect_to challenge_url(@challenge, :ok => true)
    else
      flash[:danger] = "Please fill answer valid text!"
      redirect_to challenge_url(@challenge, :ok => false)
    end
  end

  def compare
    @property = params[:property] || 'impact'
    @challenge = Challenge.find_by_id params[:challenge_id]

    @left = Answer.find_by_id params[:answer_id]
    @right = Answer.find_by_id params[:right_id]
  end

  def swap
    @property = params[:property] || 'impact'
    @selected = Answer.find_by_id params[:selected]
    @challenge = Challenge.find_by_id params[:challenge_id]

    @left = Answer.find_by_id params[:answer_id]
    @right = Answer.find_by_id params[:right_id]

    @min = [ @left[@property], @right[@property] ].min
    @max = [ @left[@property], @right[@property] ].max

    if @selected.id == @left.id
      @left[@property] = @max
      @right[@property] = @min
    else
      @left[@property] = @min
      @right[@property] = @max
    end

    if @left.save and @right.save
      puts "Saved!"
    end

    @next = Answer.where(["id > ? and id != ? and challenge_id = ? and selected = ?", @right.id, @left.id, @challenge, true]).order(:id).first

    if @next
      redirect_to challenge_answer_compare_url :challenge_id => @challenge, :answer_id => @left, :right_id => @next, :property => @property
    else
      redirect_to challenge_prepare_url :challenge_id => @challenge, :answer_id => @left, :property => @property
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @challenge = Challenge.find(params[:challenge_id])

    if params[:selected] and (@challenge.answers.select{ |answer| answer.selected == true }.count + 1) > 5
      return render json: {
        error: "Can not select more than 5 answers",
        status: 400
      }, status: 400
    end

     if @answer.update(select_params)
       return render json: @answer
     else
       return render json: @answer.errors
     end
  end

  private

  def select_params
    params.permit(:selected)
  end

  def answer_params
    params.require(:answer).permit(:text)
  end

  def check_mode
    @challenge = Challenge.find_by_id params[:id] || params[:challenge_id]
    unless @challenge.mode == 'complete'
      redirect_to challenge_report_url(@challenge)
    end
  end
end
