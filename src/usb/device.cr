class USB::Device
  getter context : Context

  def initialize(@unwrap : LibUSB::DeviceRef, @context : Context)
    LibUSB.ref_device(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    LibUSB.unref_device(self)
  end
end
