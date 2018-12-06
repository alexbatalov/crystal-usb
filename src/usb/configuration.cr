struct USB::Configuration
  getter configuration_value : UInt8
  getter attributes : UInt8
  getter max_power : UInt8
  getter interfaces : Array(Interface)
  getter extra : Bytes?

  def initialize(@configuration_value : UInt8, @attributes : UInt8, @max_power : UInt8, @interfaces : Array(Interface), @extra : Bytes?)
  end
end
