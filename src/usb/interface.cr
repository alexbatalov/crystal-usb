struct USB::Interface
  getter interface_number : UInt8
  getter alternate_setting : UInt8
  getter interface_class : UInt8
  getter interface_subclass : UInt8
  getter interface_protocol : UInt8
  getter endpoints : Array(Endpoint)
  getter extra : Bytes?

  def initialize(@interface_number : UInt8, @alternate_setting : UInt8, @interface_class : UInt8, @interface_subclass : UInt8, @interface_protocol : UInt8, @endpoints : Array(Endpoint), @extra : Bytes? = nil)
  end
end
