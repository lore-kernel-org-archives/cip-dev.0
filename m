From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:18 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/17] Add USB2.0 support
Message-ID: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add USB2.0 support for iWave iwg23s sbc based on RZ/G1C.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (16):
  dt-bindings: phy: rcar-gen2: Add r8a7744 support
  dt-bindings: phy: rcar-gen2: Add r8a77470 support
  dt-bindings: rcar-gen3-phy-usb2: Add r8a77470 support
  phy: phy-rcar-gen2: Add support for r8a77470
  phy: rcar-gen3-usb2: Add support for r8a77470
  ARM: dts: r8a77470: Add USB-DMAC device nodes
  ARM: dts: r8a77470: Add USB PHY DT support
  ARM: dts: r8a77470: Add USB2.0 Host (EHCI/OHCI) device
  ARM: shmobile: Enable PHY_RCAR_GEN3_USB2 in shmobile_defconfig
  ARM: shmobile: Enable USB [EO]HCI HCD PLATFORM support in
    shmobile_defconfig
  ARM: dts: iwg23s-sbc: Enable USB Phy[01]
  ARM: dts: iwg23s-sbc: Enable USB USB2.0 Host
  dt-bindings: usb: renesas_usbhs: Add support for r8a7744
  dt-bindings: usb: renesas_usbhs: Add support for r8a77470
  ARM: dts: r8a77470: Add HSUSB device nodes
  ARM: dts: iwg23s-sbc: Enable HS-USB

Yoshihiro Shimoda (1):
  phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver

 .../devicetree/bindings/phy/rcar-gen2-phy.txt      |  48 ++++-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  39 ++++
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   2 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |  44 ++++
 arch/arm/boot/dts/r8a77470.dtsi                    | 185 ++++++++++++++++
 arch/arm/configs/shmobile_defconfig                |   3 +
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rcar-gen2.c                        | 130 ++++++++++--
 drivers/phy/phy-rcar-gen3-usb2.c                   | 236 +++++++++++++++++++++
 10 files changed, 682 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
 create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c

-- 
2.7.4
