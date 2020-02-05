From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:26 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/35] Renesas RZ/G2 extend peripheral
	support
Message-ID: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series adds supports for following peripherals supported by RZ/G2N
a] CAN and CANFD
b] IPMMU/FCPF/FCPV/VSP
c] USB
d] DU/LVDS/HDMI/FDP1/PWM

This patch series is based on top of series [1] all the patches 
in this series are cherry-picked from upstream.

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=235707&submitter=&state=*&q=&archive=both&delegate=

Biju Das (21):
  dt-bindings: iommu: ipmmu-vmsa: Add r8a774b1 support
  iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
  arm64: dts: renesas: r8a774b1: Add IPMMU device nodes
  arm64: dts: renesas: r8a774b1: Add FCPF and FCPV instances
  arm64: dts: renesas: r8a774b1: Add VSP instances
  arm64: dts: renesas: r8a774b1: Tie SYS-DMAC to IPMMU-DS0/1
  arm64: dts: renesas: r8a774b1: Connect Ethernet-AVB to IPMMU-DS0
  arm64: dts: renesas: hihope-common: Move du clk properties out of
    common dtsi
  drm: rcar-du: Add R8A774B1 support
  arm64: dts: renesas: r8a774b1: Add DU device to DT
  arm64: dts: renesas: r8a774b1: Add HDMI encoder instance
  arm64: dts: renesas: r8a774b1-hihope-rzg2n: Add display clock
    properties
  arm64: dts: renesas: r8a774b1: Add FDP1 device nodes
  arm64: dts: renesas: r8a774b1: Add PWM device nodes
  arm64: dts: renesas: hihope-rzg2-ex: Enable backlight
  drm: rcar-du: lvds: Add r8a774b1 support
  arm64: dts: renesas: hihope-rzg2-ex: Add LVDS support
  arm64: dts: renesas: Add support for Advantech idk-1110wr LVDS panel
  arm64: dts: renesas: r8a774a1: Remove audio port node
  ASoC: rsnd: Document r8a774b1 bindings
  arm64: dts: renesas: r8a774b1: Add Sound and Audio DMAC device nodes

Fabrizio Castro (12):
  dt-bindings: can: rcar_can: document r8a774b1 support
  dt-bindings: can: rcar_canfd: document r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support
  dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
  dt-bindings: dmaengine: usb-dmac: Add binding for r8a774b1
  dt-bindings: usb: renesas_usbhs: Add r8a774b1 support
  dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support
  dt-bindings: usb-xhci: Add r8a774b1 support
  dt-bindings: usb: renesas_usb3: Document r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add USB2.0 phy and host (EHCI/OHCI)
    device nodes
  arm64: dts: renesas: r8a774b1: Add USB-DMAC and HSUSB device nodes
  arm64: dts: renesas: r8a774b1: Add USB3.0 device nodes

Simon Horman (2):
  dt-bindings: usb: renesas_usbhs: Rename bindings documentation file
  dt-bindings: usb: renesas_gen3: Rename bindings documentation file to
    reflect IP block

 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   1 +
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |   1 +
 .../devicetree/bindings/net/can/rcar_can.txt       |   3 +-
 .../devicetree/bindings/net/can/rcar_canfd.txt     |   7 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |   2 +
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   1 +
 .../devicetree/bindings/usb/renesas,usb3-peri.txt  |  41 +
 .../devicetree/bindings/usb/renesas,usbhs.txt      |  53 ++
 .../devicetree/bindings/usb/renesas_usb3.txt       |  40 -
 .../devicetree/bindings/usb/renesas_usbhs.txt      |  52 --
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 arch/arm64/boot/dts/renesas/hihope-common.dtsi     |  28 +-
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |  49 ++
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m.dts     |  11 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts     |  11 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 959 ++++++++++++++++++++-
 .../renesas/rzg2-advantech-idk-1110wr-panel.dtsi   |  41 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |  30 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   1 +
 drivers/iommu/ipmmu-vmsa.c                         |   5 +
 21 files changed, 1201 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usbhs.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas_usb3.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2-advantech-idk-1110wr-panel.dtsi

-- 
2.7.4
