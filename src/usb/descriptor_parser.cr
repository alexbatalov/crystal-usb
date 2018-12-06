struct USB::DescriptorParser
  getter device : Device

  def initialize(@device : Device)
  end

  def parse
    configurations = [] of Configuration

    device.device_descriptor.configurations_count.times do |idx|
      r = LibUSB.get_config_descriptor(device, idx, out configuration_descriptor_ptr)
      raise "libusb_get_config_descriptor" if r < 0

      configurations << parse_configuration_descriptor(configuration_descriptor_ptr.value)

      LibUSB.free_config_descriptor(configuration_descriptor_ptr)
    end

    configurations
  end

  def parse_configuration_descriptor(configuration_descriptor : LibUSB::ConfigurationDescriptor)
    interfaces = [] of Interface

    configuration_descriptor.interfaces_count.times do |interface_idx|
      interface = configuration_descriptor.interfaces[interface_idx]

      interface.alternate_settings_count.times do |interface_descriptor_idx|
        interface_descriptor = interface.alternate_settings[interface_descriptor_idx]
        interfaces << parse_interface_descriptor(interface_descriptor)
      end
    end

    extra = parse_extra(configuration_descriptor)

    Configuration.new(
      configuration_descriptor.configuration_value,
      configuration_descriptor.attributes,
      configuration_descriptor.max_power,
      interfaces,
      extra
    )
  end

  def parse_interface_descriptor(interface_descriptor : LibUSB::InterfaceDescriptor)
    endpoints = [] of Endpoint

    interface_descriptor.endpoints_count.times do |idx|
      endpoint_descriptor = interface_descriptor.endpoints[idx]
      endpoints << parse_endpoint_descriptor(endpoint_descriptor)
    end

    extra = parse_extra(interface_descriptor)

    Interface.new(
      interface_descriptor.interface_number,
      interface_descriptor.alternate_setting,
      interface_descriptor.interface_class,
      interface_descriptor.interface_subclass,
      interface_descriptor.interface_protocol,
      endpoints,
      extra
    )
  end

  def parse_endpoint_descriptor(endpoint_descriptor : LibUSB::EndpointDescriptor)
    extra = parse_extra(endpoint_descriptor)

    Endpoint.new(
      endpoint_descriptor.endpoint_address,
      endpoint_descriptor.attributes,
      endpoint_descriptor.interval,
      endpoint_descriptor.max_packet_size,
      extra
    )
  end

  private def parse_extra(descriptor)
    return if descriptor.extra_length == 0

    extra = Bytes.new(descriptor.extra_length)
    extra.copy_from(descriptor.extra, descriptor.extra_length)
    extra
  end
end
