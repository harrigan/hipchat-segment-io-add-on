module SegmentIO
  class IdentifyAction < Action
    attr_reader :user_id, :created, :email, :firstName, :lastName, :name, :username, :phone, :userAgent, :ip

    def initialize params
      super
      @user_id = params[:user_id]
      unless params[:traits].nil?
        @created = params[:traits][:created]
        @email = params[:traits][:email]
        @firstName = params[:traits][:firstName]
        @lastName = params[:traits][:lastName]
        @name = params[:traits][:name]
        @username = params[:traits][:username]
        @phone = params[:traits][:phone]
      end
      unless params[:context].nil?
        @userAgent = params[:context][:userAgent]
        @ip = params[:context][:ip]
      end
    end

    def to_s
      s = super
      s += ", user id: #{user_id}" unless user_id.nil?
      s += ", email: #{email}" unless email.nil?
      s += ", first name: #{firstName}" unless firstName.nil?
      s += ", last name: #{lastName}" unless lastName.nil?
      s += ", name: #{name}" unless name.nil?
      s += ", username: #{username}" unless username.nil?
      s += ", phone: #{phone}" unless phone.nil?
      s += ", user agent: #{userAgent}" unless userAgent.nil?
      s += ", ip: #{ip}" unless ip.nil?
      s
    end
  end
end
