ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
    address:              Settings.smtp.address,
    port:                 '587',
    domain:               Settings.smtp.domain,
    user_name:            Settings.smtp.user_name,
    password:             Settings.smtp.password,
    openssl_verify_mode:  'none',
    authentication:       :plain,
    enable_starttls_auto: true
}
