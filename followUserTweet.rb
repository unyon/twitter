#!/usr/bin/env ruby

require 'twitter'

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

        rClient.search("chance to win", result_type: "popular").take(13).each do |tweet|
            if tweet.is_a?(Twitter::Tweet)
              puts "@#{tweet.user.screen_name}:#{tweet.text}"
              puts tweet.user.screen_name 
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