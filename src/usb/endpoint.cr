struct USB::Endpoint
  getter endpoint_address : UInt8
  getter attributes : UInt8
  getter interval : UInt8
  getter max_packet_size : UInt16
  getter extra : Bytes?

  def initialize(@endpoint_address : UInt8, @attributes : UInt8, @interval : UInt8, @max_packet_size : UInt16, @extra : Bytes?)
  end
end
