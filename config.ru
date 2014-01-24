require "./lib/app"

run Rack::Cascade.new [SegmentIO::API, SegmentIO::Web]
