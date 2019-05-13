From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:25 +0100
Subject: [cip-dev] [PATCH 4.4.y 00/52] Add basic support for the iwg23s
Message-ID: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

This series adds basic support for the iwg23s from iWave, based
on the RZ/G1C (a.k.a. r8a77470).

Thanks,
Fab

Biju Das (30):
  ARM: shmobile: r8a77470: basic SoC support
  pinctrl: sh-pfc: Add r8a77470 PFC support
  pinctrl: sh-pfc: r8a77470: Add EtherAVB pin groups
  soc: renesas: rcar-rst: Add support for RZ/G1C
  ARM: debug-ll: Add support for r8a77470
  gpiolib: Avoid calling chip->request() for unused gpios
  gpio: rcar: Add GPIO hole support
  dt-bindings: gpio: rcar: Add gpio-reserved-ranges support
  ARM: shmobile: defconfig: Enable r8a77470 SoC
  ARM: multi_v7_defconfig: Enable r8a77470 SoC
  serial: sh-sci: Document r8a77470 bindings
  ARM: dts: r8a77470: Initial SoC device tree
  dt-bindings: arm: Document iW-RainboW-G23S single board computer
  ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C
  dt-bindings: pinctrl: sh-pfc: Document r8a77470 PFC support
  ARM: dts: r8a77470: Add PFC support
  dt-bindings: gpio: rcar: Add r8a77470 (RZ/G1C) support
  ARM: dts: r8a77470: Add GPIO support
  ARM: dts: r8a77470: Add SCIF support
  dt-bindings: irqchip: renesas-irqc: Document r8a77470 support
  ARM: dts: r8a77470: Add IRQC support
  ARM: dts: iwg23s-sbc: Add pinctl support for scif1
  dt-bindings: rcar-dmac: Document r8a77470 support
  ARM: dts: r8a77470: Add SYS-DMAC support
  ARM: dts: r8a77470: Add SCIF DMA support
  dt-bindings: net: renesas-ravb: Add support for r8a77470 SoC
  ARM: dts: r8a77470: Add EtherAVB support
  ARM: dts: iwg23s-sbc: Add EtherAVB support
  ARM: dts: iwg23s-sbc: specify EtherAVB PHY IRQ
  ARM: dts: iwg23s-sbc: Add pinctl support for EtherAVB

Fabrizio Castro (16):
  clk: shmobile: rcar-gen2: Add quirks for the RZ/G1C
  clk: shmobile: Compile clk-rcar-gen2.c when using the r8a77470
  ARM: shmobile: r8a77470: Add clock index macros for DT sources
  pinctrl: sh-pfc: r8a77470: Add I2C4 pin groups
  pinctrl: sh-pfc: r8a77470: Add DU0 pin groups
  pinctrl: sh-pfc: r8a77470: Add QSPI0 pin groups
  pinctrl: sh-pfc: r8a77470: Add SDHI2 pin groups
  pinctrl: sh-pfc: r8a77470: Add USB pin groups
  pinctrl: sh-pfc: r8a77470: Add remaining I2C pin groups
  pinctrl: sh-pfc: r8a77470: Add DU1 pin groups
  pinctrl: sh-pfc: r8a77470: Add VIN pin groups
  pinctrl: sh-pfc: r8a77470: Add QSPI1 pin groups
  clk: shmobile: Document r8a77470 CPG clock support
  clk: shmobile: Document r8a77470 CPG DIV6 clock support
  clk: shmobile: Document r8a77470 MSTP clock support
  ARM: dts: r8a77470: Add clocks

Geert Uytterhoeven (3):
  gpio: rcar: Implement gpiochip.set_multiple()
  dt-bindings: sram: Document renesas,smp-sram
  dt-bindings: rcar-dmac: Document missing error interrupt

Stephen Boyd (3):
  gpiolib: Extract mask allocation into subroutine
  gpiolib: Support 'gpio-reserved-ranges' property
  dt-bindings: gpio: Add a gpio-reserved-ranges property

 Documentation/devicetree/bindings/arm/shmobile.txt |    4 +
 .../bindings/clock/renesas,cpg-div6-clocks.txt     |    1 +
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |    1 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    6 +-
 Documentation/devicetree/bindings/gpio/gpio.txt    |    7 +-
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   44 +-
 .../bindings/interrupt-controller/renesas,irqc.txt |    1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |    1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |    1 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 .../devicetree/bindings/sram/renesas,smp-sram.txt  |   27 +
 arch/arm/Kconfig.debug                             |   13 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |   68 +
 arch/arm/boot/dts/r8a77470.dtsi                    |  764 +++++
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/shmobile_defconfig                |    1 +
 arch/arm/mach-shmobile/Kconfig                     |    4 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |    2 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    2 +
 drivers/clk/shmobile/Makefile                      |    1 +
 drivers/clk/shmobile/clk-rcar-gen2.c               |   39 +-
 drivers/gpio/gpio-rcar.c                           |   23 +
 drivers/gpio/gpiolib-of.c                          |   24 +
 drivers/gpio/gpiolib.c                             |   64 +-
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/core.h                      |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c              | 3292 ++++++++++++++++++++
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 include/dt-bindings/clock/r8a77470-clock.h         |  140 +
 include/linux/gpio/driver.h                        |   18 +
 35 files changed, 4541 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77470.c
 create mode 100644 include/dt-bindings/clock/r8a77470-clock.h

-- 
2.7.4
