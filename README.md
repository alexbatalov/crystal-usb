# crystal-usb

[libusb](https://libusb.info) for [Crystal](https://crystal-lang.org).

## Installation

1. Install `libusb-1.0`:

In `macOS`:
```console
$ brew install libusb
```

In `Debian/Ubuntu`:
```console
$ sudo apt-get install libusb-1.0
```

2. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  usb:
    github: alexbatalov/crystal-usb
```

3. Run `shards install`

## Usage

At this time the library exposes everything `libusb` has to offer through
`LibUSB` bindings. These bindings are (hopefully) stable and will follow
`libusb` releases.

```crystal
require "usb"

r = LibUSB.init(out ctx)
raise "libusb_init" if r < 0

cnt = LibUSB.get_device_list(ctx, out devices)
raise "libusb_get_device_list" if cnt < 0

cnt.times do |i|
  device = devices[i]

  LibUSB.get_device_descriptor(device, out device_descriptor)
  next unless device_descriptor.vendor_id == 0x0001 && device_descriptor.product_id == 0x0002

  r = LibUSB.open(device, out device_handle)
  raise "libusb_open" if r < 0

  r = LibUSB.claim_interface(device_handle, 0x00)
  raise "libusb_claim_interface" if r < 0

  data = Bytes.new(2)
  r = LibUSB.interrupt_transfer(device_handle, 0x81, data, data.size, out transferred, 0)
  raise "libusb_interrupt_transfer" if r < 0

  r = LibUSB.release_interface(device_handle, 0x00)
  raise "libusb_release_interface" if r < 0

  LibUSB.close(device_handle)
end

LibUSB.free_device_list(devices, 1)

LibUSB.exit(ctx)
```

I'm working on wrapping this C-like mess into high-level objects.

## Roadmap

- [x] Bindings
- [ ] Core API
- [ ] Examples

## License

MIT
