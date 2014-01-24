module SegmentIO
  class Web < ::Sinatra::Base
    get "/" do
      account = Account.new
      account.save
      @account_id = account.id
      erb :index
    end

    get "/support" do
      erb :support
    end

    get "/hipchat/configure/:account_id" do
      if account = Account.find(params[:account_id])
        token = ::JWT.decode params["signed_request"], nil, nil
        account.hipchat_oauth_id = token["iss"]
        account.hipchat_oauth_issued_at = token["iat"]
        account.hipchat_user_id = token["prn"]
        account.hipchat_config_context = token["context"]
        account.save
      else
        raise NoAccountError
      end
      erb :configure
    end

    get "/thank_you" do
      erb :thank_you
    end

    error NoAccountError do
      flash[:error] = "We couldn't find your account, please contact support."
      redirect to("/support")
    end
  end
end
