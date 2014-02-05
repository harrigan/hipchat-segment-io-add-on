module SegmentIO
  class API < ::Grape::API
    version "v1", using: :header, vendor: "Martin Harrigan"
    format :json

    resource :hipchat do
      desc "Describes the add-on and what its capabilities are"
      params do
        requires :account_id, type: String,
          desc: "The account this add-on will be installed to"
      end
      get "capabilities/:account_id" do
        {
          name: "SegmentIO",
          description: "",
          key: "ie.martinharrigan.hipchat.segment_io",
          links: {
            homepage: ENV["BASE_URI"],
            self: "#{ENV['BASE_URI']}/hipchat/capabilities/#{params[:account_id]}"
          },
          vendor: {
            url: "http://www.martinharrigan.ie",
            name: "Martin Harrigan"
          },
          capabilities: {
            hipchatApiConsumer: {
              scopes: ENV["HIPCHAT_SCOPES"].split(" ")
            },
            configurable: {
              url: "#{ENV['BASE_URI']}/hipchat/configure/#{params[:account_id]}"
            },
            installable: {
              callbackUrl: "#{ENV['BASE_URI']}/hipchat/install/#{params[:account_id]}"
            }
          }
        }
      end

      desc "Receive installation notification"
      params do
        requires :account_id, type: String,
          desc: "Account that has installed the add-on"
      end
      post "install/:account_id" do
        if account = Account.find(params[:account_id])
          # Update account
          account.hipchat_oauth_id = params[:oauthId]
          account.hipchat_oauth_secret = params[:oauthSecret]
          account.hipchat_installed = true
          account.hipchat_capabilities_url = params[:capabilitiesUrl]

          # Verify capabilities
          response = open(URI.parse(params[:capabilitiesUrl]))
          capabilities = JSON.parse(response.read)
          raise UnexpectedApplicationError if capabilities["name"] != "HipChat"

          # Request an OAuth token
          token_url = capabilities["capabilities"]["oauth2Provider"]["tokenUrl"]
          authorization_url = capabilities["capabilities"]["oauth2Provider"]["authorizationUrl"]

          client = OAuth2::Client.new(
            account.hipchat_oauth_id,
            account.hipchat_oauth_secret,
            site: token_url,
            scope: ENV["HIPCHAT_SCOPES"],
            token_url: token_url,
            authorization_url: authorization_url
          )

          token = client.client_credentials.get_token({scope: ENV["HIPCHAT_SCOPES"] }).token
          account.hipchat_oauth_token = token

          account.save
          200
        else
          # Responding with error status will cause the installation to fail
          raise NoAccountError
        end
      end

      desc "Receive uninstallation notification"
      params do
        requires :account_id, type: String,
          desc: "Account that has removed the add-on"
        requires :oauth_id, type: String,
          desc: "OAuth ID value for the installation"
      end
      delete "install/:account_id/:oauth_id" do
        if account = Account.find(params[:account_id])
          account.hipchat_installed = false
          account.save
        else
          # Uninstallation will continue anyway, we just can't
          # track it to an account.
          raise NoAccountError
        end
      end
    end

    resource :segment_io do
      desc "Receive action"
      params do
        requires :account_id, type: String
        requires :room_id_or_name, type: String
        requires :action, type: String
      end
      post "/:account_id/:room_id_or_name" do
        account = Account.find(params[:account_id])
        access_token = HipChat::get_access_token account.hipchat_oauth_id, account.hipchat_oauth_secret
        action = Action::create params
        unless action.is_a?(TrackAction) && action.event == "Loaded a Page"
          HipChat::send_notification params[:room_id_or_name], action.to_s, access_token
        end
      end
    end
  end
end
