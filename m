From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 14 Feb 2020 20:32:53 +0000
Subject: [cip-dev] [ANNOUNCE] Release v4.19.103-cip20 and v4.4.213-cip42
Message-ID: <OSAPR01MB3667EF4D96C5C13C476497F492150@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

CIP kernel team has released Linux kernel v4.19.103-cip20 and v4.4.213-cip42.
The linux-4.19.y-cip tree has been updated base version from v4.19.98 to v4.19.103,
and many features of r8a774b1 have been added.
Then the linux-4.4.y-cip tree has been updated base version from v4.4.208 to v4.4.213,
and QSPI, TPU, PWM, VSP, USB and  MSIOF support for r8a7744 has been added.

We can get this release via the git tree at:

  v4.19.103-cip20:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      d8d2f780968e403b42ecf61d498032ade45546d0
    added commits:
      CIP: Bump version suffix to -cip20 after merge from stable
      arm64: dts: renesas: r8a774b1: Add USB3.0 device nodes
      arm64: dts: renesas: r8a774b1: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774b1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
      dt-bindings: usb: renesas_usb3: Document r8a774b1 support
      dt-bindings: usb: renesas_gen3: Rename bindings documentation file to reflect IP block
      dt-bindings: usb-xhci: Add r8a774b1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support
      dt-bindings: usb: renesas_usbhs: Add r8a774b1 support
      dt-bindings: usb: renesas_usbhs: Rename bindings documentation file
      dt-bindings: dmaengine: usb-dmac: Add binding for r8a774b1
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
      arm64: dts: renesas: r8a774b1: Add Sound and Audio DMAC device nodes
      ASoC: rsnd: Document r8a774b1 bindings
      arm64: dts: renesas: r8a774a1: Remove audio port node
      arm64: dts: renesas: Add support for Advantech idk-1110wr LVDS panel
      arm64: dts: renesas: hihope-rzg2-ex: Add LVDS support
      drm: rcar-du: lvds: Add r8a774b1 support
      arm64: dts: renesas: hihope-rzg2-ex: Enable backlight
      arm64: dts: renesas: r8a774b1: Add PWM device nodes
      arm64: dts: renesas: r8a774b1: Add FDP1 device nodes
      arm64: dts: renesas: r8a774b1-hihope-rzg2n: Add display clock properties
      arm64: dts: renesas: r8a774b1: Add HDMI encoder instance
      arm64: dts: renesas: r8a774b1: Add DU device to DT
      drm: rcar-du: Add R8A774B1 support
      arm64: dts: renesas: hihope-common: Move du clk properties out of common dtsi
      arm64: dts: renesas: r8a774b1: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: r8a774b1: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a774b1: Add VSP instances
      arm64: dts: renesas: r8a774b1: Add FCPF and FCPV instances
      arm64: dts: renesas: r8a774b1: Add IPMMU device nodes
      iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
      dt-bindings: iommu: ipmmu-vmsa: Add r8a774b1 support
      arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support
      dt-bindings: can: rcar_canfd: document r8a774b1 support
      dt-bindings: can: rcar_can: document r8a774b1 support
      arm64: dts: renesas: r8a774b1: Add TMU device nodes
      clk: renesas: r8a774b1: Add TMU clock
      dt-bindings: timer: renesas: tmu: Document r8a774b1 bindings
      arm64: dts: renesas: r8a774b1: Add CMT device nodes
      dt-bindings: timer: renesas, cmt: Document r8a774b1 CMT support
      arm64: dts: renesas: r8a774b1: Add RZ/G2N thermal support
      thermal: rcar_gen3_thermal: Add r8a774b1 support
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a774b1 support
      arm64: dts: renesas: r8a774b1: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a774b1: Add I2C and IIC-DVFS support
      dt-bindings: i2c: sh_mobile: Add r8a774b1 support
      dt-bindings: i2c: sh_mobile: Rename bindings documentation file
      dt-bindings: i2c: rcar: Add r8a774b1 support
      dt-bindings: i2c: rcar: Rename bindings documentation file
      arm64: dts: renesas: r8a774b1-hihope-rzg2n: Enable HS400 mode
      arm64: dts: renesas: r8a774b1: Add SDHI support
      mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support
      dt-bindings: mmc: renesas_sdhi: Add r8a774b1 support
      arm64: dts: renesas: r8a774b1: Add INTC-EX device node
      arm64: dts: renesas: hihope-rzg2-ex: Let the board specific DT decide about pciec1
      arm64: dts: renesas: r8a774b1: Add PCIe device nodes
      arm64: dts: renesas: r8a774b1: Add all MSIOF nodes
      arm64: dts: renesas: r8a774b1: Add RWDT node
      dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
      dt-bindings: watchdog: Rename bindings documentation file
      dt-bindings: spi: sh-msiof: Add r8a774b1 support
      arm64: dts: renesas: Add HiHope RZ/G2N sub board support
      arm64: dts: renesas: r8a774b1: Add Ethernet AVB node
      dt-bindings: net: ravb: Add support for r8a774b1 SoC
      arm64: dts: renesas: r8a774b1: Add GPIO device nodes
      dt-bindings: gpio: rcar: Add DT binding for r8a774b1
      arm64: dts: renesas: r8a774b1: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774b1: Add SYS-DMAC device nodes
      dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings

  v4.4.213-cip42:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      2507dd95fec1b330c3c62881e43d3d10d44a1a04
    added commits:
      CIP: Bump version suffix to -cip42 after merge from stable
      ARM: dts: r8a7744: Add PCIe Controller device node
      ARM: dts: r8a7744: Add xhci support
      dt-bindings: usb-xhci: Document r8a7744 support
      usb: host: xhci-plat: Add r8a7744 support
      ARM: dts: r8a7744-iwg20m: Add SPI NOR support
      ARM: dts: r8a7744: Add MSIOF[012] support
      ARM: dts: r8a7744: Add QSPI support
      ARM: dts: r8a7744: Add TPU support
      ARM: dts: r8a7744: Add PWM SoC support
      ARM: dts: r8a7744: Add VSP support

Best regards,
   Nobuhiro
