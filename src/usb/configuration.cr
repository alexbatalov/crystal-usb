struct USB::Configuration
  private SELF_POWERED_MASK  = 1 << 6
  private REMOTE_WAKEUP_MASK = 1 << 5

  getter configuration_value : UInt8
  getter attributes : UInt8
  getter max_power : UInt8
  getter interfaces : Array(Interface)
  getter extra : Bytes?

  def initialize(@configuration_value : UInt8, @attributes : UInt8, @max_power : UInt8, @interfaces : Array(Interface), @extra : Bytes?)
  end

  def self_powered?
    attributes.bits_set?(SELF_POWERED_MASK)
  end

  def remote_wakeup?
    attributes.bits_set?(REMOTE_WAKEUP_MASK)
  end
end
