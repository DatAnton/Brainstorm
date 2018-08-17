class ChallengeController < ApplicationController
  def new
    @challenge = Challenge.new(challenge_creation_params)
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.valid?
      @challenge.save
      redirect_to :action=>"show", :controller=>"challenge", id: @challenge.id
    else
      render 'new'
    end
  end

  def show
    @answer = Answer.new
    @challenge = Challenge.find_by id: params[:id]
  end

  def result
    @challenge = Challenge.find_by id: params[:challenge_id]
    @answers = @challenge.answers
  end

  def challenge_creation_params
      params.permit(:mode)
  end

  def challenge_params
    params.require(:challenge).permit(:problem, :time, :mode)
  end
end
