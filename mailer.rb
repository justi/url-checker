require_relative 'mail'

class Mailer
    def initialize(rules_with_errors)
        @rules_with_errors = rules_with_errors

    end

    def prepare_msg
        msg = msg_body
        @rules_with_errors.each do |rule|
           msg += "<p>#{rule.to_s}</p>"
        end
        msg
    end

    def send
        message = prepare_msg
        Mail.deliver do
           to 'recipient_email'
           from 'sender_email'
           subject 'testing sendmail'

           html_part do
               content_type 'text/html; charset=UTF-8'
            body message
           end
        end
    end

    def msg_body
        <<MESSAGE_END
            This is an e-mail message to be sent in HTML format

            <b>This is HTML message.</b>
            <h1>This is headline.</h1>
MESSAGE_END
    end
end
