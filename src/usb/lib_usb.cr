@[Link("libusb-1.0")]
lib LibUSB
  alias Int = LibC::Int
  alias UInt = LibC::UInt

  ENDPOINT_NUMBER_MASK         = 0x0F
  ENDPOINT_DIRECTION_MASK      = 0x80
  ENDPOINT_TRANSFER_TYPE_MASK  = 0x03
  ENDPOINT_ISO_SYNC_TYPE_MASK  = 0x0C
  ENDPOINT_ISO_USAGE_TYPE_MASK = 0x30

  HOTPLUG_MATCH_ANY = -1

  type ContextRef = Void*
  type DeviceRef = Void*
  type DeviceHandleRef = Void*

  # libusb_bos_descriptor
  struct BOSDescriptor
    length : UInt8
    descriptor_type : UInt8
    total_length : UInt16
    device_capabilities_count : UInt8
    device_capabilities : DeviceCapabilityDescriptor*
  end

  # libusb_bos_dev_capability_descriptor
  struct DeviceCapabilityDescriptor
    length : UInt8
    descriptor_type : UInt8
    device_capability_type : UInt8
    buffer : UInt8*
  end

  # libusb_config_descriptor
  struct ConfigurationDescriptor
    length : UInt8
    descriptor_type : UInt8
    total_length : UInt16
    interfaces_count : UInt8
    configuration_value : UInt8
    configuration_description : UInt8
    attributes : UInt8
    max_power : UInt8
    interfaces : Interface*
    extra : UInt8*
    extra_length : Int
  end

  # libusb_container_id_descriptor
  struct ContainerIdDescriptor
    length : UInt8
    descriptor_type : UInt8
    device_capability_type : UInt8
    reserved : UInt8
    container_id : UInt8[16]
  end

  # libusb_control_setup
  struct ControlSetup
    request_type : UInt8
    request : UInt8
    value : UInt16
    index : UInt16
    length : UInt16
  end

  # libusb_device_descriptor
  struct DeviceDescriptor
    length : UInt8
    descriptor_type : UInt8
    usb_version : UInt16
    device_class : UInt8
    device_subclass : UInt8
    device_protocol : UInt8
    max_packet_size_0 : UInt8
    vendor_id : UInt16
    product_id : UInt16
    device_version : UInt16
    manufacturer_description : UInt8
    product_description : UInt8
    serial_number_description : UInt8
    configurations_count : UInt8
  end

  # libusb_endpoint_descriptor
  struct EndpointDescriptor
    length : UInt8
    descriptor_type : UInt8
    endpoint_address : UInt8
    attributes : UInt8
    max_packet_size : UInt16
    interval : UInt8
    refresh : UInt8
    sync_address : UInt8
    extra : UInt8*
    extra_length : Int
  end

  # libusb_interface
  struct Interface
    alternate_settings : InterfaceDescriptor*
    alternate_settings_count : Int
  end

  # libusb_interface_descriptor
  struct InterfaceDescriptor
    length : UInt8
    descriptor_type : UInt8
    interface_number : UInt8
    alternate_setting : UInt8
    endpoints_count : UInt8
    interface_class : UInt8
    interface_subclass : UInt8
    interface_protocol : UInt8
    interface_description : UInt8
    endpoints : EndpointDescriptor*
    extra : UInt8*
    extra_length : Int
  end

  # libusb_iso_packet_descriptor
  struct IsochronousPacket
    length : UInt
    actual_length : UInt
    status : TransferStatus
  end

  # libusb_pollfd
  struct FileDescriptor
    fd : Int
    events : LibC::Short
  end

  # libusb_ss_endpoint_companion_descriptor
  struct SuperSpeedEndpointCompanionDescriptor
    length : UInt8
    descriptor_type : UInt8
    max_burst : UInt8
    attributes : UInt8
    bytes_per_interval : UInt16
  end

  # libusb_ss_usb_device_capability_descriptor
  struct SuperSpeedUSBDescriptor
    length : UInt8
    descriptor_type : UInt8
    device_capability_type : UInt8
    attributes : UInt8
    speeds_supported : UInt16
    functionality_support : UInt8
    u1_device_exit_latency : UInt8
    u2_device_exit_latency : UInt16
  end

  # libusb_transfer
  struct Transfer
    device_handle : DeviceHandleRef
    flags : UInt8
    endpoint_address : UInt8
    transfer_type : UInt8
    timeout : UInt
    status : TransferStatus
    length : Int
    actual_length : Int
    callback : TransferCallback
    user_data : Void*
    buffer : UInt8*
    isochronous_packets_count : Int
    isochronous_packets : IsochronousPacket*
  end

  # libusb_usb_2_0_extension_descriptor
  struct USB20ExtensionDescriptor
    length : UInt8
    descriptor_type : UInt8
    device_capability_type : UInt8
    attributes : UInt32
  end

  # libusb_version
  struct Version
    major : UInt16
    minor : UInt16
    micro : UInt16
    nano : UInt16
    rc : UInt8*
    description : UInt8*
  end

  # libusb_bos_type
  enum DeviceCapabilityType : UInt8
    WIRELESS_USB      = 1
    USB_2_0_EXTENSION = 2
    SUPERSPEED_USB    = 3
    CONTAINER_ID      = 4
  end

  # libusb_capability
  enum Capability
    HAS_CAPABILITY                = 0x0000
    HAS_HOTPLUG                   = 0x0001
    HAS_HID_ACCESS                = 0x0100
    SUPPORTS_DETACH_KERNEL_DRIVER = 0x0101
  end

  # libusb_class_code
  enum Class : UInt8
    PER_INTERFACE       =    0
    AUDIO               =    1
    COMM                =    2
    HID                 =    3
    PHYSICAL            =    5
    PRINTER             =    7
    PTP                 =    6
    IMAGE               =    6
    MASS_STORAGE        =    8
    HUB                 =    9
    DATA                =   10
    SMART_CARD          = 0x0B
    CONTENT_SECURITY    = 0x0D
    VIDEO               = 0x0E
    PERSONAL_HEALTHCARE = 0x0F
    DIAGNOSTIC_DEVICE   = 0xDC
    WIRELESS            = 0xE0
    APPLICATION         = 0xFE
    VENDOR_SPECIFIC     = 0xFF
  end

  # libusb_descriptor_type
  enum DescriptorType : UInt8
    DEVICE                        = 0x01
    CONFIG                        = 0x02
    STRING                        = 0x03
    INTERFACE                     = 0x04
    ENDPOINT                      = 0x05
    BOS                           = 0x0F
    DEVICE_CAPABILITY             = 0x10
    HID                           = 0x21
    REPORT                        = 0x22
    PHYSICAL                      = 0x23
    HUB                           = 0x29
    SUPERSPEED_HUB                = 0x2A
    SUPERSPEED_ENDPOINT_COMPANION = 0x30
  end

  # libusb_endpoint_direction
  enum EndpointDirection : UInt8
    IN  = 0x80
    OUT = 0x00
  end

  # libusb_error
  enum Error
    SUCCESS       =   0
    IO            =  -1
    INVALID_PARAM =  -2
    ACCESS        =  -3
    NO_DEVICE     =  -4
    NOT_FOUND     =  -5
    BUSY          =  -6
    TIMEOUT       =  -7
    OVERFLOW      =  -8
    PIPE          =  -9
    INTERRUPTED   = -10
    NO_MEM        = -11
    NOT_SUPPORTED = -12
    OTHER         = -99
  end

  # libusb_iso_sync_type
  enum IsoSyncType : UInt8
    NONE     = 0
    ASYNC    = 1
    ADAPTIVE = 2
    SYNC     = 3
  end

  # libusb_iso_usage_type
  enum IsoUsageType : UInt8
    DATA     = 0
    FEEDBACK = 1
    IMPLICIT = 2
  end

  # libusb_log_level
  enum LogLevel
    NONE    = 0
    ERROR   = 1
    WARNING = 2
    INFO    = 3
    DEBUG   = 4
  end

  # libusb_option
  enum Option
    LOG_LEVEL
    USE_USBDK
  end

  # libusb_request_recipient
  enum RequestRecipient : UInt8
    DEVICE    = 0x00
    INTERFACE = 0x01
    ENDPOINT  = 0x02
    OTHER     = 0x03
  end

  # libusb_request_type
  enum RequestType : UInt8
    STANDARD = 0x00 << 5
    CLASS    = 0x01 << 5
    VENDOR   = 0x02 << 5
    RESERVED = 0x03 << 5
  end

  # libusb_speed
  enum Speed
    UNKNOWN    = 0
    LOW        = 1
    FULL       = 2
    HIGH       = 3
    SUPER      = 4
    SUPER_PLUS = 5
  end

  # libusb_ss_usb_device_capability_attributes
  @[Flags]
  enum SuperSpeedUSBAttributes : UInt8
    LTM_SUPPORT = 2
  end

  # libusb_standard_request
  enum StandardRequest : UInt8
    GET_STATUS        = 0x00
    CLEAR_FEATURE     = 0x01
    SET_FEATURE       = 0x03
    SET_ADDRESS       = 0x05
    GET_DESCRIPTOR    = 0x06
    SET_DESCRIPTOR    = 0x07
    GET_CONFIGURATION = 0x08
    SET_CONFIGURATION = 0x09
    GET_INTERFACE     = 0x0A
    SET_INTERFACE     = 0x0B
    SYNC_FRAME        = 0x0C
    SET_SEL           = 0x30
    SET_ISO_DELAY     = 0x31
  end

  # libusb_supported_speed
  @[Flags]
  enum SupportedSpeed : UInt16
    LOW   = 1
    FULL  = 2
    HIGH  = 4
    SUPER = 8
  end

  # libusb_transfer_flags
  @[Flags]
  enum TransferFlags : UInt8
    SHORT_NOT_OK    = 1 << 0
    FREE_BUFFER     = 1 << 1
    FREE_TRANSFER   = 1 << 2
    ADD_ZERO_PACKET = 1 << 3
  end

  # libusb_transfer_status
  enum TransferStatus
    COMPLETED
    ERROR
    TIMEOUT
    CANCELED
    STALL
    NO_DEVICE
    OVERFLOW
  end

  # libusb_transfer_type
  enum TransferType : UInt8
    CONTROL     = 0
    ISOCHRONOUS = 1
    BULK        = 2
    INTERRUPT   = 3
    BULK_STREAM = 4
  end

  # libusb_usb_2_0_extension_attributes
  @[Flags]
  enum USB20ExtensionAttributes : UInt32
    LPM_SUPPORT = 2
  end

  # libusb_hotplug_flags
  @[Flags]
  enum HotplugFlags
    ENUMERATE = 1 << 0
  end

  # libusb_hotplug_event
  @[Flags]
  enum HotplugEvents
    DEVICE_ARRIVED = 0x01
    DEVICE_LEFT    = 0x02
  end

  alias HotplugCallback = (ContextRef, DeviceRef, HotplugEvents, Void*) -> Int
  alias HotplugHandle = Int

  alias TransferCallback = Transfer* ->

  fun alloc_streams = libusb_alloc_streams(device_handle : DeviceHandleRef, streams_count : UInt32, endpoint_addresses : UInt8*, endpoint_addresses_count : Int) : Int
  fun alloc_transfer = libusb_alloc_transfer(iso_packets_count : Int) : Transfer*
  fun attach_kernel_driver = libusb_attach_kernel_driver(device_handle : DeviceHandleRef, interface_number : Int) : Int
  @[Raises]
  fun bulk_transfer = libusb_bulk_transfer(device_handle : DeviceHandleRef, endpoint_address : UInt8, buffer : UInt8*, length : Int, transferred : Int*, timeout : UInt) : Int
  fun cancel_transfer = libusb_cancel_transfer(transfer : Transfer*) : Int
  fun claim_interface = libusb_claim_interface(device_handle : DeviceHandleRef, interface_number : Int) : Int
  fun clear_halt = libusb_clear_halt(device_handle : DeviceHandleRef, endpoint_address : UInt8) : Int
  fun close = libusb_close(device_handle : DeviceHandleRef)
  @[Raises]
  fun control_transfer = libusb_control_transfer(device_handle : DeviceHandleRef, request_type : UInt8, request : UInt8, value : UInt16, index : UInt16, buffer : UInt8*, length : UInt16, timeout : UInt) : Int
  fun control_transfer_get_data = libusb_control_transfer_get_data(transfer : Transfer*) : UInt8*
  fun control_transfer_get_setup = libusb_control_transfer_get_setup(transfer : Transfer*) : ControlSetup*
  fun detach_kernel_driver = libusb_detach_kernel_driver(device_handle : DeviceHandleRef, interface_number : Int) : Int
  fun dev_mem_alloc = libusb_dev_mem_alloc(device_handle : DeviceHandleRef, length : LibC::SizeT) : UInt8*
  fun dev_mem_free = libusb_dev_mem_free(device_handle : DeviceHandleRef, buffer : UInt8*, length : LibC::SizeT) : Int
  fun get_error_name = libusb_error_name(error : Error) : UInt8*
  fun event_handler_active = libusb_event_handler_active(context : ContextRef) : Int
  fun event_handling_ok = libusb_event_handling_ok(context : ContextRef) : Int
  fun exit = libusb_exit(context : ContextRef)
  fun fill_bulk_stream_transfer = libusb_fill_bulk_stream_transfer(transfer : Transfer*, device_handle : DeviceHandleRef, endpoint_address : UInt8, stream_id : UInt32, buffer : UInt8*, length : Int, callback : TransferCallback, user_data : Void*, timeout : UInt)
  fun fill_bulk_transfer = libusb_fill_bulk_transfer(transfer : Transfer*, device_handle : DeviceHandleRef, endpoint_address : UInt8, buffer : UInt8*, length : Int, callback : TransferCallback, user_data : Void*, timeout : UInt)
  fun fill_control_setup = libusb_fill_control_setup(buffer : UInt8*, request_type : UInt8, request : UInt8, value : UInt16, index : UInt16, length : UInt16)
  fun fill_control_transfer = libusb_fill_control_transfer(transfer : Transfer*, device_handle : DeviceHandleRef, buffer : UInt8*, callback : TransferCallback, user_data : Void*, timeout : UInt)
  fun fill_interrupt_transfer = libusb_fill_interrupt_transfer(transfer : Transfer*, device_handle : DeviceHandleRef, endpoint_address : UInt8, buffer : UInt8*, length : Int, callback : TransferCallback, user_data : Void*, timeout : UInt)
  fun fill_iso_transfer = libusb_fill_iso_transfer(transfer : Transfer*, device_handle : DeviceHandleRef, endpoint_address : UInt8, buffer : UInt8*, length : Int, iso_packets_count : Int, callback : TransferCallback, user_data : Void*, timeout : UInt)
  fun free_bos_descriptor = libusb_free_bos_descriptor(descriptor : BOSDescriptor*)
  fun free_config_descriptor = libusb_free_config_descriptor(descriptor : ConfigurationDescriptor*)
  fun free_container_id_descriptor = libusb_free_container_id_descriptor(descriptor : ContainerIdDescriptor*)
  fun free_device_list = libusb_free_device_list(device_list : DeviceRef*, unref_devices : Int)
  fun free_pollfds = libusb_free_pollfds(poll_fds_list : FileDescriptor**)
  fun free_ss_endpoint_companion_descriptor = libusb_free_ss_endpoint_companion_descriptor(descriptor : SuperSpeedEndpointCompanionDescriptor*)
  fun free_ss_usb_device_capability_descriptor = libusb_free_ss_usb_device_capability_descriptor(descriptor : SuperSpeedUSBDescriptor*)
  fun free_streams = libusb_free_streams(device_handle : DeviceHandleRef, endpoint_addresses : UInt8*, endpoint_addresses_count : Int) : Int
  fun free_transfer = libusb_free_transfer(transfer : Transfer*)
  fun free_usb_2_0_extension_descriptor = libusb_free_usb_2_0_extension_descriptor(descriptor : USB20ExtensionDescriptor*)
  fun get_active_config_descriptor = libusb_get_active_config_descriptor(device : DeviceRef, descriptor : ConfigurationDescriptor**) : Int
  fun get_bos_descriptor = libusb_get_bos_descriptor(device_handle : DeviceHandleRef, descriptor : BOSDescriptor**) : Int
  fun get_bus_number = libusb_get_bus_number(device : DeviceRef) : UInt8
  fun get_config_descriptor = libusb_get_config_descriptor(device : DeviceRef, index : UInt8, descriptor : ConfigurationDescriptor**) : Int
  fun get_config_descriptor_by_value = libusb_get_config_descriptor_by_value(device : DeviceRef, configuration_value : UInt8, descriptor : ConfigurationDescriptor**) : Int
  fun get_configuration = libusb_get_configuration(device_handle : DeviceHandleRef, configuration_value : Int*) : Int
  fun get_container_id_descriptor = libusb_get_container_id_descriptor(context : ContextRef, device_capability_descriptor : DeviceCapabilityDescriptor*, container_id_descriptor : ContainerIdDescriptor**) : Int
  fun get_descriptor = libusb_get_descriptor(device_handle : DeviceHandleRef, descriptor_type : UInt8, index : UInt8, buffer : UInt8*, length : Int) : Int
  fun get_device = libusb_get_device(device_handle : DeviceHandleRef) : DeviceRef
  fun get_device_address = libusb_get_device_address(device : DeviceRef) : UInt8
  fun get_device_descriptor = libusb_get_device_descriptor(device : DeviceRef, descriptor : DeviceDescriptor*) : Int
  fun get_device_list = libusb_get_device_list(context : ContextRef, device_list : DeviceRef**) : LibC::SSizeT
  fun get_device_speed = libusb_get_device_speed(device : DeviceRef) : Speed
  fun get_iso_packet_buffer = libusb_get_iso_packet_buffer(transfer : Transfer*, index : UInt) : UInt8*
  fun get_iso_packet_buffer_simple = libusb_get_iso_packet_buffer_simple(transfer : Transfer*, index : UInt) : UInt8*
  fun get_max_iso_packet_size = libusb_get_max_iso_packet_size(device : DeviceRef, endpoint_address : UInt8) : Int
  fun get_max_packet_size = libusb_get_max_packet_size(device : DeviceRef, endpoint_address : UInt8) : Int
  fun get_next_timeout = libusb_get_next_timeout(context : ContextRef, tv : LibC::Timeval*) : Int
  fun get_parent = libusb_get_parent(device : DeviceRef) : DeviceRef
  fun get_pollfds = libusb_get_pollfds(context : ContextRef) : FileDescriptor**
  fun get_port_number = libusb_get_port_number(device : DeviceRef) : UInt8
  fun get_port_numbers = libusb_get_port_numbers(device : DeviceRef, port_numbers : UInt8*, port_numbers_count : Int) : Int
  fun get_port_path = libusb_get_port_path(context : ContextRef, device : DeviceRef, port_numbers : UInt8*, port_numbers_count : Int) : Int
  fun get_ss_endpoint_companion_descriptor = libusb_get_ss_endpoint_companion_descriptor(context : ContextRef, endpoint_descriptor : EndpointDescriptor*, ss_endpoint_companion_descriptor : SuperSpeedEndpointCompanionDescriptor**) : Int
  fun get_ss_usb_device_capability_descriptor = libusb_get_ss_usb_device_capability_descriptor(context : ContextRef, device_capability_descriptor : DeviceCapabilityDescriptor*, ss_usb_descriptor : SuperSpeedUSBDescriptor**) : Int
  fun get_string_descriptor = libusb_get_string_descriptor(device_handle : DeviceHandleRef, index : UInt8, lang_id : UInt16, buffer : UInt8*, length : Int) : Int
  fun get_string_descriptor_ascii = libusb_get_string_descriptor_ascii(device_handle : DeviceHandleRef, index : UInt8, buffer : UInt8*, length : Int) : Int
  fun get_usb_2_0_extension_descriptor = libusb_get_usb_2_0_extension_descriptor(context : ContextRef, device_capability_descriptor : DeviceCapabilityDescriptor*, usb_2_extension_descriptor : USB20ExtensionDescriptor**) : Int
  fun get_version = libusb_get_version : Version*
  @[Raises]
  fun handle_events = libusb_handle_events(context : ContextRef) : Int
  @[Raises]
  fun handle_events_completed = libusb_handle_events_completed(context : ContextRef, completed : Int*) : Int
  @[Raises]
  fun handle_events_locked = libusb_handle_events_locked(context : ContextRef, tv : LibC::Timeval*) : Int
  @[Raises]
  fun handle_events_timeout = libusb_handle_events_timeout(context : ContextRef, tv : LibC::Timeval*) : Int
  @[Raises]
  fun handle_events_timeout_completed = libusb_handle_events_timeout_completed(context : ContextRef, tv : LibC::Timeval*, completed : Int*) : Int
  fun has_capability = libusb_has_capability(capability : UInt32) : Int
  fun hotplug_deregister_callback = libusb_hotplug_deregister_callback(context : ContextRef, handle : HotplugHandle)
  fun hotplug_register_callback = libusb_hotplug_register_callback(context : ContextRef, events : HotplugEvents, flags : HotplugFlags, vendor_id : Int, product_id : Int, device_class : Int, callback : HotplugCallback, user_data : Void*, handle : HotplugHandle*) : Int
  fun init = libusb_init(context : ContextRef*) : Int
  fun interrupt_event_handler = libusb_interrupt_event_handler(context : ContextRef)
  @[Raises]
  fun interrupt_transfer = libusb_interrupt_transfer(device_handle : DeviceHandleRef, endpoint_address : UInt8, buffer : UInt8*, length : Int, transferred : Int*, timeout : UInt) : Int
  fun kernel_driver_active = libusb_kernel_driver_active(device_handle : DeviceHandleRef, interface_number : Int) : Int
  fun lock_events = libusb_lock_events(context : ContextRef)
  fun lock_event_waiters = libusb_lock_event_waiters(context : ContextRef)
  fun open = libusb_open(device : DeviceRef, device_handle : DeviceHandleRef*) : Int
  fun open_device_with_vid_pid = libusb_open_device_with_vid_pid(context : ContextRef, vendor_id : UInt16, product_id : UInt16) : DeviceHandleRef
  fun pollfds_handle_timeout = libusb_pollfds_handle_timeout(context : ContextRef) : Int
  fun ref_device = libusb_ref_device(device : DeviceRef) : DeviceRef
  fun release_interface = libusb_release_interface(device_handle : DeviceHandleRef, interface_number : Int) : Int
  fun reset_device = libusb_reset_device(device_handle : DeviceHandleRef) : Int
  fun set_auto_detach_kernel_driver = libusb_set_auto_detach_kernel_driver(device_handle : DeviceHandleRef, enabled : Int) : Int
  fun set_configuration = libusb_set_configuration(device_handle : DeviceHandleRef, configuration_value : Int) : Int
  fun set_debug = libusb_set_debug(context : ContextRef, log_level : LogLevel)
  fun set_interface_alt_setting = libusb_set_interface_alt_setting(device_handle : DeviceHandleRef, interface_number : Int, alternate_setting : Int) : Int
  fun set_iso_packet_lengths = libusb_set_iso_packet_lengths(transfer : Transfer*, length : UInt)
  fun set_option = libusb_set_option(context : ContextRef, option : Option, ...) : Int
  fun set_locale = libusb_setlocale(locale : UInt8*) : Int
  fun set_pollfd_notifiers = libusb_set_pollfd_notifiers(context : ContextRef, added_callback : (Int, LibC::Short, Void*) ->, removed_callback : (Int, Void*) ->, user_data : Void*)
  fun get_error_description = libusb_strerror(error : Error) : UInt8*
  fun submit_transfer = libusb_submit_transfer(transfer : Transfer*) : Int
  fun transfer_get_stream_id = libusb_transfer_get_stream_id(transfer : Transfer*) : UInt32
  fun transfer_set_stream_id = libusb_transfer_set_stream_id(transfer : Transfer*, stream_id : UInt32)
  fun try_lock_events = libusb_try_lock_events(context : ContextRef) : Int
  fun unlock_events = libusb_unlock_events(context : ContextRef)
  fun unlock_event_waiters = libusb_unlock_event_waiters(context : ContextRef)
  fun unref_device = libusb_unref_device(device : DeviceRef)
  fun wait_for_event = libusb_wait_for_event(context : ContextRef, tv : LibC::Timeval*) : Int
end
