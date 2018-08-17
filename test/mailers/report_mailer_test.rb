require 'test_helper'

class ReportMailerTest < ActionMailer::TestCase
  test "challenge_report" do
    mail = ReportMailer.challenge_report
    assert_equal "Challenge report", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
