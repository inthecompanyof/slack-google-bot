require 'http'

module SlackGoogleBot
  module Commands
    class Google < SlackRubyBot::Commands::Base
      match(/^(?<bot>\w*)\s(?<expression>.*)$/) do |client, data, match|
        expression = match['expression'].strip
        results = JSON.parse HTTP.get('https://www.googleapis.com/customsearch/v1',
                                      params: {
                                        q: expression,
                                        key: ENV['GOOGLE_API_KEY'],
                                        cx: ENV['GOOGLE_CSE_ID']
                                      })
        result = results['items'].first if results['items']
        if results['items']
          results['items'].each do |result|
	           message = result['htmlTitle'] + "\n" + result['link'] + "\n" + result['snippet'] +"\n"
	            client.say(text: message, channel: data.channel)
        end
        else
          message = "No search results for `#{expression}`"
          client.say(text: message, channel: data.channel)
        end
      end
    end
  end
end
