class ReportMailer < ApplicationMailer
  default from: 'notifications@example.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.challenge_report.subject
  #
  # def challenge_report(email, subj, id)
  #   @challenge = Challenge.find id
  #   @better = Answer.where(["challenge_id = ? and selected = ?", id, true]).order(:impact => :desc, :cost => :asc).first
  #
  #   mail(to: email, subject: "Brainstorm #{subj}")
  # end

  def challenge_report
    #@challenge = Challenge.find(params[:challenge_id])
    # @better = Answer.where(["challenge_id = ? and selected = ?", id, true]).order(:impact => :desc, :cost => :asc).first

    mail(to: "tom.dacenko@gmail.com", subject: "Brainstorm")
  end

end
