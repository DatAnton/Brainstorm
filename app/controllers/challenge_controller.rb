class ChallengeController < ApplicationController
  before_action :check_mode, :only => [:matrix, :prepare]

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

    if @challenge.expired
      redirect_to challenge_result_url @challenge
    end
  end

  def result
    @challenge = Challenge.find_by id: params[:challenge_id]
    @answers = @challenge.answers
  end

  def report
    @challenge = Challenge.find params[:challenge_id]
    @better = Answer.where(["challenge_id = ? and selected = ?", params[:challenge_id], true]).order(:impact => :desc, :cost => :asc).first
  end

  def intent
    @property = params[:property] || 'impact'
    @challenge = Challenge.find_by_id params[:challenge_id]

    if @challenge.impact_flag and @challenge.cost_flag
      return redirect_to challenge_matrix_url :challenge_id => @challenge
    end

    @url = params[:redirect_to] || challenge_prepare_path(@challenge)
  end

  def matrix
    @challenge = Challenge.find_by id: params[:challenge_id]
    @answers = Answer.where(["selected = ? and challenge_id = ?", true, @challenge.id])
  end

  def challenge_creation_params
      params.permit(:mode)
  end

  def challenge_params
    params.require(:challenge).permit(:problem, :time, :mode)
  end

  def extra_time_params
    params.permit(:time)
  end

  def send_report
    @challenge = Challenge.find params[:challenge_id]
    @better = Answer.where(["challenge_id = ? and selected = ?", params[:challenge_id], true]).order(:impact => :desc, :cost => :asc).first
    # ReportMailer.challenge_report(params[:email], params[:subject], params[:challenge_id]).deliver_now
    # ReportMailer.challenge_report("tom.dacenko@gmail.com", "Brainstorm", @challenge.id).deliver_now
    ReportMailer.challenge_report(params[:email], params[:subject], params[:challenge_id]).deliver
    redirect_to challenge_report_url(@challenge)
  end

  def prepare
    @property = params[:property] || 'impact'
    @challenge = Challenge.find_by_id params[:challenge_id]

    if @challenge.impact_flag and @challenge.cost_flag
      return redirect_to challenge_matrix_url :challenge_id => @challenge
    elsif @property == 'impact' and @challenge.impact_flag
      return redirect_to challenge_intent_url :challenge_id => @challenge, :property => 'cost'
    elsif @property == 'cost' and @challenge.cost_flag
      return redirect_to challenge_intent_url :challenge_id => @challenge, :property => 'impact'
    end

    if params[:answer_id]
      @left = Answer.where(["id > ? and challenge_id = ? and selected = ?", params[:answer_id], @challenge, true]).order(:id).first
    else
      @left = Answer.where(["challenge_id = ? and selected = ?", @challenge, true]).order(:id).first
    end

    if @left
      @right = Answer.where(["id > ? and challenge_id = ? and selected = ?", @left.id, @challenge, true]).order(:id).first
      if @right
        return redirect_to challenge_answer_compare_url :challenge_id => @challenge, :property => @property, :answer_id => @left, :right_id => @right
      else
        return redirect_to challenge_prepare_path(:challenge_id => @challenge, :property => @property, :answer_id => @left.id)
      end
    else
      if @property == 'impact'
        @challenge.update_attributes :impact_flag => true
      elsif @property == 'cost'
        @challenge.update_attributes :cost_flag => true
      end
      @next_prop = @property == 'cost' ? 'impact' : 'cost'
      @url = challenge_prepare_path :challenge_id => @challenge, :property => @next_prop
      return redirect_to challenge_intent_url :challenge_id => @challenge, :redirect_to => @url, :property => @next_prop
    end

  end

  def prepare_old
    @property = params[:property] || 'impact'
    @challenge = Challenge.find_by_id params[:challenge_id]

    if @challenge.impact_flag and @challenge.cost_flag
      return redirect_to challenge_matrix_url :challenge_id => @challenge
    end

    if params[:answer_id]
      @left = Answer.where(["id > ? and challenge_id = ? and selected = ?", params[:answer_id], @challenge, true]).order(:id).first
    else
      @left = Answer.where(["challenge_id = ? and selected = ?", @challenge, true]).order(:id).first
    end

    unless @left
      puts "end of left"
      if @property == 'impact'
        @challenge.impact_flag = true
        if @challenge.save
          puts "Saved!"
        end

        @url = challenge_prepare_path(:challenge_id => @challenge, :property => 'cost')
        return redirect_to challenge_intent_url :challenge_id => @challenge, :property => 'cost', :redirect_to => @url
      elsif @property == 'cost'
        @challenge.cost_flag = true
        if @challenge.save
          puts "Saved!"
        end
        return redirect_to challenge_matrix_url :challenge_id => @challenge
      else
        return redirect_to challenge_prepare_path :challenge_id => @challenge, :property => @property, :challenge_id => params[:challenge_id]
      end
    end

    # != to >
    @right = Answer.where(["id > ? and challenge_id = ? and selected = ?", @left.id, @challenge, true]).order(:id).first

    if @right
      return redirect_to challenge_answer_compare_url :challenge_id => @challenge, :property => @property, :answer_id => @left, :right_id => @right
    else
      @url = challenge_prepare_path(:challenge_id => @challenge, :property => 'cost')
      return redirect_to challenge_intent_url :challenge_id => @challenge, :property => 'cost', :redirect_to => @url
      # if @property == 'impact'
      #   @challenge.impact_flag = true
      #   redirect_to challenge_prepare_url :challenge_id => @challenge, :property => 'cost'
      # else
      #   @challenge.cost_flag = true
      #   redirect_to challenge_matrix :challenge_id => @challenge
      # end
    end
  end

  def extra
    @challenge = Challenge.find params[:challenge_id]
    @extra_time = @challenge.extra_times.build extra_time_params

    if @extra_time.save
      redirect_to challenge_url @challenge
    else
      redirect_to challenge_result_url @challenge
    end
  end

  private
  def check_mode
    @challenge = Challenge.find_by_id params[:id] || params[:challenge_id]
    unless @challenge.mode == 'complete'
      redirect_to challenge_report_url(@challenge)
    end
  end
end
