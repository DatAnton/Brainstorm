config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            '<brainstormapp0@gmail.com>',
  password:             '<brainSTORM>',
  authentication:       'plain',
  enable_starttls_auto: true }


  # ActionMailer::Base.smtp_settings = {
  #    :address        => 'gmail.com',
  #    :port           => '587',
  #    :authentication => :plain,
  #    :user_name      => ENV['brainstormapp0@gmail.com'],
  #    :password       => ENV['brainSTORM'],
  #    :domain         => 'smtp.gmail.com',
  #    :enable_starttls_auto => true
  #  }
