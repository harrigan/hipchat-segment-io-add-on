module SegmentIO
  module HipChat
    def self.get_access_token oauth_id, oauth_secret
      response = HTTParty.post "https://api.hipchat.com/v2/oauth/token?grant_type=client_credentials&scope=send_notification", :basic_auth => {
        :username => oauth_id,
        :password => oauth_secret
      }
      JSON.parse(response.body)["access_token"]
    end

    def self.send_notification room, notification, access_token
      headers = {"Content-type" => "application/json"}
      body = {
        :color => "purple",
        :message_format => "text",
        :message => notification
      }.to_json
      HTTParty.post "https://api.hipchat.com/v2/room/#{room}/notification?auth_token=#{access_token}", :body => body, :headers => headers
    end
  end
end
