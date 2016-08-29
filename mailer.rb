require_relative 'mail'

class Mailer
    def initialize(rules_with_errors)
        @rules_with_errors = rules_with_errors
    end

    def admin_email
        ENV['URL_CHECKER_MAILER_ADMIN']
    end

    def prepare_msg
        msg = msg_body

        if @rules_with_errors.any?
            @rules_with_errors.each do |rule|
               msg += "<p>#{rule.to_s}</p>"
            end
        else
            msg += "No errors!"
        end
        msg
    end

    def send
        message = prepare_msg
        admin_e = admin_email
        Mail.deliver do
           to admin_e
           from "sender@some.email"
           subject 'Url checker report'

           html_part do
               content_type 'text/html; charset=UTF-8'
           body message
           end
        end
    end

    def msg_body
        <<MESSAGE_END
            <h1>Report</h1>
MESSAGE_END
    end
end
