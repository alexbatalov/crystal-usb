class USB::Context
  getter? closed = false

  def self.new
    r = LibUSB.init(out ref)
    raise "libusb_init" if r < 0

    new(ref)
  end

  def initialize(@unwrap : LibUSB::ContextRef)
  end

  def devices
    devs = [] of Device

    count = LibUSB.get_device_list(self, out refs)
    raise "libusb_get_device_list" if count < 0

    begin
      count.times do |n|
        devs << Device.find_or_initialize(refs[n], self)
      end
    ensure
      LibUSB.free_device_list(refs, 1)
    end

    devs
  end

  def close
    return if closed?
    @closed = true

    LibUSB.exit(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    close
  end
end
