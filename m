From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Tue, 18 Feb 2020 14:04:57 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/23] Renesas RZ/G2E USB Type-C
	Backport
Message-ID: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patchset revolves around the following patch set from upstream:
https://patchwork.kernel.org/cover/10969899/

Unfortunately, the driver is using a slightly different version of the USB
API. In upstream, the connection between the fwnode of the USB controller
device tree node, that is the connector device tree node, and the USB
peripheral device tree node is nicely done via some new function calls that
are basically some extensions to the graph traverse and graph discovery
methods for the device tree parser. This is needed for role switch feature.

I tried to create the minimum set for the USB API extension and it should
not affect at all the current behavior. All the modifications are additions
and some rewritings of some of the current functions.

I also backported some fixes where I have found them.

Tested on Si-Linux EK874 (with RZ/G2E SoC) that we have in house.

Biju Das (8):
  dt-bindings: usb: hd3ss3220 device tree binding document
  dt-bindings: usb: renesas_usb3: Document usb role switch support
  usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
  usb: typec: hd3ss3220: hd3ss3220_probe() warn: passing zero to
    'PTR_ERR'
  usb: gadget: udc: renesas_usb3: Enhance role switch support
  arm64: defconfig: enable TYPEC_HD3SS3220 config option
  arm64: dts: renesas: cat874: Enable USB3.0 host/peripheral device node
  arm64: dts: renesas: cat874: Enable usb role switch support

Dan Carpenter (1):
  usb: typec: fix an IS_ERR() vs NULL bug in hd3ss3220_probe()

Heikki Krogerus (10):
  device connection: Add fwnode member to struct device_connection
  usb: typec: mux: Find the muxes by also matching against the device
    node
  usb: roles: Find the muxes by also matching against the device node
  usb: typec: Find the ports by also matching against the device node
  device connection: Prepare support for firmware described connections
  device connection: Find device connections also from device graphs
  device property: Introduce fwnode_find_reference()
  device connection: Find connections also by checking the references
  device connection: Add fwnode_connection_find_match()
  usb: roles: Add fwnode_usb_role_switch_get() function

Mao Wenan (1):
  usb: typec: add dependency for TYPEC_HD3SS3220

Yu Chen (1):
  usb: roles: Introduce stubs for the exiting functions in role.h

YueHaibing (1):
  usb: typec: mux: Fix unsigned comparison with less than zero

kbuild test robot (1):
  usb: typec: hd3ss3220_irq() can be static

 .../devicetree/bindings/usb/renesas,usb3-peri.txt  |  23 ++
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       |  38 +++
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  49 ++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/base/devcon.c                              | 107 ++++++++-
 drivers/base/property.c                            |  24 ++
 drivers/usb/gadget/udc/renesas_usb3.c              |  91 ++++++-
 drivers/usb/roles/class.c                          |  41 +++-
 drivers/usb/typec/Kconfig                          |  11 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/class.c                          |  24 +-
 drivers/usb/typec/hd3ss3220.c                      | 262 +++++++++++++++++++++
 drivers/usb/typec/mux.c                            |  86 ++++++-
 include/linux/device.h                             |  16 +-
 include/linux/property.h                           |   4 +
 include/linux/usb/role.h                           |  38 +++
 16 files changed, 786 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,hd3ss3220.txt
 create mode 100644 drivers/usb/typec/hd3ss3220.c

-- 
2.7.4
