class USB::DeviceHandle
  getter device : Device
  getter? closed = false

  def initialize(@unwrap : LibUSB::DeviceHandleRef, @device : Device)
  end

  def close
    return if closed?

    LibUSB.close(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    close
  end
end
