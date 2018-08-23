class ReportMailer < ApplicationMailer
  default from: 'brainstorm@app.com'

  def challenge_report(email, subj, ch_id)
    @challenge = Challenge.find(ch_id)
    @better = Answer.where(["challenge_id = ? and selected = ?", ch_id, true]).order(:impact => :desc, :cost => :asc).first
    mail(:to => email, :subject => subj )
  end

end
