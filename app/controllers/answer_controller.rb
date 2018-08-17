class AnswerController < ApplicationController
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

end
