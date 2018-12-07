struct USB::Endpoint
  getter endpoint_address : UInt8
  getter attributes : UInt8
  getter interval : UInt8
  getter max_packet_size : UInt16
  getter extra : Bytes?

  def initialize(@endpoint_address : UInt8, @attributes : UInt8, @interval : UInt8, @max_packet_size : UInt16, @extra : Bytes?)
  end

  def endpoint_number
    @endpoint_address & LibUSB::ENDPOINT_NUMBER_MASK
  end

  def direction
    LibUSB::EndpointDirection.new(@endpoint_address & LibUSB::ENDPOINT_DIRECTION_MASK)
  end

  def transfer_type
    LibUSB::TransferType.new(@attributes & LibUSB::ENDPOINT_TRANSFER_TYPE_MASK)
  end

  def iso_sync_type
    LibUSB::IsoSyncType.new((@attributes & LibUSB::ENDPOINT_ISO_SYNC_TYPE_MASK) >> 2) if transfer_type.isochronous?
  end

  def iso_usage_type
    LibUSB::IsoUsageType.new((@attributes & LibUSB::ENDPOINT_ISO_USAGE_TYPE_MASK) >> 4) if transfer_type.isochronous?
  end
end
