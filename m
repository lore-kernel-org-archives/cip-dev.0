From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  6 Mar 2018 11:34:40 +0000
Subject: [cip-dev] [PATCH 0/7] Add HSUSB to r8a7743
Message-ID: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series backports all the patches necessary to add HSUSB support
to the r8a7743.

Thanks,
Fabrizio

Biju Das (5):
  usb: renesas_usbhs: Add compatible string for r8a7743/5
  ARM: dts: r8a7743: Add HS-USB device node
  ARM: dts: iwg20d-q7: Enable HS-USB
  ARM: dts: r8a7743: Add USB-DMAC device nodes
  ARM: dts: r8a7743: Enable DMA for HSUSB

Simon Horman (2):
  usb: renesas_usbhs: add SoC names to compatibility string
    documentation
  usb: renesas_usbhs: add fallback compatibility strings

 .../devicetree/bindings/usb/renesas_usbhs.txt      | 22 ++++++++----
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  7 +++-
 arch/arm/boot/dts/r8a7743.dtsi                     | 40 ++++++++++++++++++++++
 drivers/usb/renesas_usbhs/common.c                 |  9 +++++
 4 files changed, 71 insertions(+), 7 deletions(-)

-- 
2.7.4
