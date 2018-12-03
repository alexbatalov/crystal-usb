require "./usb/*"
require "semantic_version"

module USB
  VERSION = "0.1.0"

  # Returns the used version of `libusb`.
  def self.libusb_version
    version = LibUSB.get_version.value
    major = version.major.to_i32
    minor = version.minor.to_i32
    micro = version.micro.to_i32
    prerelease = String.new(version.rc) unless LibC.strlen(version.rc) == 0
    SemanticVersion.new(major, minor, micro, prerelease)
  end
end
