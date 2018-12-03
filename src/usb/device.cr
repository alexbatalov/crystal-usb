class USB::Device
  getter context : Context

  def initialize(@unwrap : LibUSB::DeviceRef, @context : Context)
    LibUSB.ref_device(self)
  end

  def open
    r = LibUSB.open(self, out ref)
    raise "libusb_open" if r < 0

    DeviceHandle.new(ref, self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    LibUSB.unref_device(self)
  end
end
