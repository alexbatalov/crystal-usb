class USB::DeviceHandle
  getter device : Device
  getter? closed = false

  def initialize(@unwrap : LibUSB::DeviceHandleRef, @device : Device)
  end

  def attach_kernel_driver(interface_number : UInt8)
    r = LibUSB.attach_kernel_driver(self, interface_number)
    raise "libusb_attach_kernel_driver" if r < 0
  end

  def detach_kernel_driver(interface_number : UInt8)
    r = LibUSB.detach_kernel_driver(self, interface_number)
    raise "libusb_detach_kernel_driver" if r < 0
  end

  def kernel_driver_active?(interface_number : UInt8)
    r = LibUSB.kernel_driver_active(self, interface_number)
    raise "libusb_kernel_driver_active" if r < 0

    r != 0
  end

  def claim_interface(interface_number : UInt8)
    r = LibUSB.claim_interface(self, interface_number)
    raise "libusb_claim_interface" if r < 0
  end

  def release_interface(interface_number : UInt8)
    r = LibUSB.release_interface(self, interface_number)
    raise "libusb_release_interface" if r < 0
  end

  def set_configuration(configuration_value : UInt8)
    r = LibUSB.set_configuration(self, configuration_value)
    raise "libusb_set_configuration" if r < 0
  end

  def set_interface_alternate_setting(interface_number : UInt8, alternate_setting : UInt8)
    r = LibUSB.set_interface_alt_setting(self, interface_number, alternate_setting)
    raise "libusb_set_interface_alt_setting" if r < 0
  end

  def bulk_transfer(endpoint_address : UInt8, slice : Bytes, timeout : UInt32)
    r = LibUSB.bulk_transfer(self, endpoint_address, slice, slice.size, out transferred, timeout)
    raise "libusb_bulk_transfer" if r < 0

    transferred
  end

  def control_transfer(request_type : UInt8, request : UInt8, value : UInt16, index : UInt16, slice : Bytes, timeout : UInt32)
    r = LibUSB.control_transfer(self, request_type, request, value, index, slice, slice.length, timeout)
    raise "libusb_control_transfer" if r < 0

    r
  end

  def interrupt_transfer(endpoint_address : UInt8, slice : Bytes, timeout : UInt32)
    r = LibUSB.interrupt_transfer(self, endpoint_address, slice, slice.size, out transferred, timeout)
    raise "libusb_interrupt_transfer" if r < 0

    transferred
  end

  def close
    return if closed?
    @closed = true

    LibUSB.close(self)
  end

  def to_unsafe
    @unwrap
  end

  def finalize
    close
  end
end
