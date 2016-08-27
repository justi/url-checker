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
    end

    end

    def msg_body
        <<MESSAGE_END
            From: Private Person <me@fromdomain.com>
            To: A Test User <test@todomain.com>
            MIME-Version: 1.0
            Content-type: text/html
            Subject: SMTP e-mail test

            This is an e-mail message to be sent in HTML format

            <b>This is HTML message.</b>
            <h1>This is headline.</h1>
MESSAGE_END
    end
end
