From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:25 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/17] Add
	SYS-DMAC/GPIO/AVB/SMP/SCIF/HSCIF/I2C/IIC/CMT/RWDT support
Message-ID: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add SYS-DMAC/GPIO/AVB/SMP/SCIF/HSCIF/I2C/IIC/CMT/RWDT
support for iWave RZ/G1N platform.

Backported the relevent patches to linux-4.4.y-cip.

Biju Das (17):
  dt-bindings: rcar-dmac: Document r8a7744 support
  ARM: dts: r8a7744: Add SYS-DMAC support
  dt-bindings: gpio: rcar: Add r8a7744 (RZ/G1N) support
  ARM: dts: r8a7744: Add GPIO support
  dt-bindings: net: ravb: Add support for r8a7744 SoC
  ARM: dts: r8a7744: Add Ethernet AVB support
  dt-bindings: apmu: Document r8a7744 support
  ARM: dts: r8a7744: Add SMP support
  ARM: dts: r8a7744: Add [H]SCIF{A|B} support
  dt-bindings: i2c: rcar: Document r8a7744 support
  dt-bindings: i2c: sh_mobile: Document r8a7744 support
  ARM: dts: r8a7744: Add I2C and IIC support
  dt-bindings: timer: renesas, cmt: Document r8a7744 CMT
  ARM: dts: r8a7744: Add CMT SoC specific support
  dt-bindings: watchdog: renesas-wdt: Document r8a7744 support
  ARM: dts: r8a7744: Add RWDT node
  ARM: dts: iwg20d-q7-common: Move cmt/rwdt node out of RZ/G1M SOM

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   1 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
 .../devicetree/bindings/power/renesas,apmu.txt     |   1 +
 .../devicetree/bindings/timer/renesas,cmt.txt      |   2 +
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   1 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   9 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   9 -
 arch/arm/boot/dts/r8a7744.dtsi                     | 596 ++++++++++++++++++++-
 11 files changed, 598 insertions(+), 25 deletions(-)

-- 
2.7.4
