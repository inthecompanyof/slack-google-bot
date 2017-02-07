require 'sinatra/base'

module SlackGoogleBot
  class Web < Sinatra::Base
    get '/' do
      'Slack integration with Google, https://github.com/inthecompanyof/slack-google-bot.'
    end
  end
end
