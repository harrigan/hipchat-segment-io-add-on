module SegmentIO
  class Action
    def self.create params
      case params[:action]
      when "Identify"
        IdentifyAction.new params
      when "Track"
        TrackAction.new params
      else
        Action.new params
      end
    end

    attr_reader :version, :action

    def initialize params
      @version = params[:version]
      @action = params[:action]
    end

    def to_s
      @action
    end
  end
end
