#!/usr/bin/env ruby

require 'twitter'

# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "ZVTA1oXoBEvljLPTClqR66dRr"
#   config.consumer_secret     = "o5NeeKrvV0Dh4a5pKLdaO6rDNrsvVkRkGfs5T3V7SJG5RTJ3qY"
#   config.access_token        = "264012514-nn5Uw9Wb5FSSH6M7OY7ZOvo3mv1Q9ZGzPL7GYqWh"
#   config.access_token_secret = "65nhrzog3AqibQc5EbqeTuU66aX0A7M6z0FY4W7Gu51Rv"
# end

# client.update("I'm posting a tweet!")
while true
    begin
        # Create a read write application from : 
        # https://apps.twitter.com
        # authenticate it for your account
        # fill in the following
        config = {
            consumer_key:        '',
            consumer_secret:     '',
            access_token:        '',
            access_token_secret: ''
        }
        rClient = Twitter::REST::Client.new config
        sClient = Twitter::Streaming::Client.new(config)

        # topics to watch
        topics = ['#contest', '#win', '#prize', '#competition']
        sClient.filter(:track => topics.join(',')) do |tweet|
            if tweet.is_a?(Twitter::Tweet)
              puts tweet.text 
              rClient.retweet tweet
              rClient.favorite tweet
              rClient.follow(tweet.user.id) if tweet.user.followers.count > 1000
            end
        end
    rescue
        puts 'error occurred, waiting for 5 seconds'
        sleep 5
    end

end