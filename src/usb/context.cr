class USB::Context
  getter? closed = false

  def self.new
    r = LibUSB.init(out ref)
    raise "libusb_init" if r < 0

    new(ref)
  end

  def initialize(@unwrap : LibUSB::ContextRef)
  end

  def close
    return if closed?

    LibUSB.exit(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    close
  end
end
