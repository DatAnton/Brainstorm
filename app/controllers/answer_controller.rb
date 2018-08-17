class AnswerController < ApplicationController

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

  private

  def answer_params
    params.require(:answer).permit(:text)
  end

end
