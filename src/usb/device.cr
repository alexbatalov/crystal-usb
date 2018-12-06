class USB::Device
  getter context : Context

  protected getter device_descriptor : LibUSB::DeviceDescriptor

  delegate device_class, device_subclass, device_protocol,
    vendor_id, product_id, configurations_count, to: device_descriptor

  getter configurations : Array(Configuration) { DescriptorParser.new(self).parse }

  def initialize(@unwrap : LibUSB::DeviceRef, @context : Context)
    r = LibUSB.get_device_descriptor(unwrap, out @device_descriptor)
    raise "libusb_get_device_descriptor" if r < 0

    LibUSB.ref_device(self)
  end

  def open
    r = LibUSB.open(self, out ref)
    raise "libusb_open" if r < 0

    DeviceHandle.new(ref, self)
  end

  def bus_number
    LibUSB.get_bus_number(self)
  end

  def device_address
    LibUSB.get_device_address(self)
  end

  def port_number
    LibUSB.get_port_number(self)
  end

  def device_speed
    LibUSB.get_device_speed(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    LibUSB.unref_device(self)
  end
end
