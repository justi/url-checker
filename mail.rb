require 'mail'

options = {
    :address              => ENV['URL_CHECKER_MAILER_HOST'],
    :port                 => ENV['URL_CHECKER_MAILER_PORT'],
    :user_name            => ENV['URL_CHECKER_MAILER_USERNAME'],
    :password             => ENV['URL_CHECKER_MAILER_PASSWORD'],
    :authentication       => :plain,
    :enable_starttls_auto => true
}

Mail.defaults do
    delivery_method :smtp, options
end
