module SegmentIO
  class TrackAction < Action
    attr_reader :event, :revenue, :userAgent, :ip

    def initialize params
      super
      @event = params[:event]
      unless params[:properties].nil?
        @revenue = params[:properties][:reveue]
      end
      unless params[:context].nil?
        @userAgent = params[:context][:userAgent]
        @ip = params[:context][:ip]
      end
    end

    def to_s
      s = super
      s += ", event: #{event}" unless event.nil?
      s += ", revenue: #{revenue}" unless revenue.nil?
      s += ", user agent: #{userAgent}" unless userAgent.nil?
      s += ", ip: #{ip}" unless ip.nil?
      s
    end
  end
end
