module SegmentIO
  class Account
    include ::MongoMapper::Document
    key :hipchat_installed, Boolean

    key :hipchat_oauth_id, String
    key :hipchat_oauth_secret, String
    key :hipchat_oauth_issued_at, String
    key :hipchat_oauth_token, String

    key :hipchat_user_id, String

    key :hipchat_config_context, Object

    key :hipchat_capabilities_url, String

    timestamps!
  end
end
