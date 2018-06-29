From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:01 +0100
Subject: [cip-dev] [PATCH 00/86] First patch set for iwg22d
Message-ID: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Ben,

this series aims at adding initial support for the iwg22d, powered by
the RZ/G1E (r8a7745).
I hope this patch set is not too big, please let me know if you prefer
smaller chunks.

Thanks,
Fab

Andrey Gusakov (1):
  pinctrl: sh-pfc: r8a7794: Fix GP2[29] muxing

Benjamin Herrenschmidt (1):
  dt: Add of_device_compatible_match()

Biju Das (26):
  clk: shmobile: rcar-gen2: Add RZ/G1E to pll0_mult_match list
  clk: shmobile: Document r8a7745 CPG clock support
  clk: shmobile: Document r8a7745 CPG DIV6 clock support
  clk: shmobile: Document r8a7745 MSTP clock support
  ARM: shmobile: r8a7745: Add clock index macros for DT sources
  ARM: dts: r8a7745: Add clocks
  ARM: dts: r8a7745: add [H]SCIF{|A|B} support
  ARM: dts: iwg22m: Add iWave RZG1E SODIMM SOM
  ARM: dts: iwg22d-sodimm: Add support for iWave G22D-SODIMM board
  pinctrl: sh-pfc: r8a7794: Add i2c5 pin groups and function
  ARM: dts: iwg22d-sodimm: Add pinctl support for scif4
  gpio: rcar: Add r8a7745 (RZ/G1E) support
  ARM: dts: r8a7745: Add GPIO support
  dt-bindings: net: ravb : Add support for r8a7745 SoC
  ARM: dts: r8a7745: Add Ethernet AVB support
  ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
  ARM: dts: r8a7745: Add missing clock for secondary CA7 CPU core
  ARM: dts: r8a7745: Add internal PCI bridge nodes
  ARM: dts: r8a7745: Add USB PHY DT support
  ARM: dts: r8a7745: Link PCI USB devices to USB PHY
  ARM: dts: iwg22d-sodimm: Enable internal PCI
  ARM: dts: iwg22d-sodimm: Enable USB PHY
  ARM: dts: r8a7745: Add HS-USB device node
  ARM: dts: iwg22d-sodimm: Enable HS-USB
  ARM: dts: r8a7745: Add USB-DMAC device nodes
  ARM: dts: r8a7745: Enable DMA for HSUSB

Fabrizio Castro (30):
  ARM: shmobile: document iW-RainboW-G22M-SM SODIMM System on Module
  ARM: shmobile: document iW-RainboW-G22D SODIMM SOM Development
    Platform
  pinctrl: sh-pfc: r8a7745: Add CAN[01] support
  pinctrl: sh-pfc: r8a7794: Add can_clk function
  pinctrl: sh-pfc: r8a7794: Add PWM[0123456] support
  pinctrl: sh-pfc: r8a7794: Add tpu groups and function
  ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
  dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings
  ARM: dts: r8a7745: Add MMC interface support
  ARM: dts: iwg22m: Add eMMC support
  ARM: debug-ll: Add support for r8a7745
  ARM: shmobile: Add pm support for r8a7745
  dt-bindings: apmu: Document r8a7745 support
  ARM: dts: r8a7745: Add APMU node and second CPU core
  ARM: dts: r8a7745: Add operating-points to cpu0
  ARM: dts: r8a7745: Add I2C DT support
  ARM: dts: r8a7745: Add IIC cores to dtsi
  ARM: dts: iwg22m: Add RTC support
  ARM: dts: r8a7745: Add SDHI controllers
  ARM: dts: iwg22m: Enable SDHI1 controller
  ARM: dts: iwg22d: Enable SDHI0 controller
  ARM: dts: iwg22d: Add /dev/ttySC5 support
  ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for HDMI DB
  ARM: dts: r8a7745: Add QSPI support
  ARM: dts: iwg22m: Add SPI NOR support
  of: add vendor prefix for Silicon Storage Technology Inc.
  ARM: dts: r8a7745: Add MSIOF[012] support
  drm: rcar-du: Add R8A7745 support
  ARM: dts: r8a7745: Add DU support
  ARM: dts: iwg22d-sodimm-dbhd-ca: Add HDMI video output

Geert Uytterhoeven (11):
  ARM: shmobile: rcar-gen2: Correct arch timer frequency on RZ/G1E
  clk: renesas: rcar-gen2: Fix PLL0 on R-Car V2H and E2
  ARM: dts: r8a7745: Link ARM GIC to clock and clock domain
  ARM: dts: r8a7745: Fix SCIFB0 dmas indentation
  ARM: dts: r8a7745: Remove unit-address and reg from integrated cache
  pinctrl: sh-pfc: r8a7794: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: r8a7794: Add SCIF_CLK support
  ARM: Add definition for monitor mode
  ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15
  ARM: shmobile: rcar-gen2: Make rcar_gen2_dma_contiguous static
  ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss

Koji Matsuoka (1):
  pinctrl: sh-pfc: r8a7794: Add DU pin groups

Marc Zyngier (1):
  ARM: DTS: Fix register map for virt-capable GIC

Ryo Kataoka (2):
  pinctrl: sh-pfc: r8a7794: Add SSI pin groups
  pinctrl: sh-pfc: r8a7794: Add audio clock pin groups

Sergei Shtylyov (11):
  ARM: dts: r8a7745: initial SoC device tree
  ARM: dts: r8a7745: add SYS-DMAC support
  ARM: dts: r8a7745: add Ether support
  ARM: dts: r8a7745: add IRQC support
  pinctrl: sh-pfc: r8a7794: Add EtherAVB pin groups
  pinctrl: sh-pfc: r8a7794: Swap ATA signals
  pinctrl: sh-pfc: r8a7794: Rename some I2C signals
  pinctrl: sh-pfc: r8a7794: Remove AVB_AVTP_* groups
  pinctrl: sh-pfc: r8a7794: Remove reserved bits
  pinctrl: sh-pfc: r8a7794: Add R8A7745 support
  ARM: dts: r8a7745: add PFC support

Simon Horman (2):
  gpio: rcar: add gen[123] fallback compatibility strings
  ARM: dts: r8a7743: Use R-Car GPIO Gen2 fallback compat string

 Documentation/devicetree/bindings/arm/shmobile.txt |    4 +
 .../bindings/clock/renesas,cpg-div6-clocks.txt     |    1 +
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |    1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |    1 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   15 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |    1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |    1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 .../devicetree/bindings/power/renesas,apmu.txt     |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig.debug                             |   10 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/r8a7743.dtsi                     |   16 +-
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |  146 ++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |  134 ++
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |  111 +
 arch/arm/boot/dts/r8a7745.dtsi                     | 1391 +++++++++++
 arch/arm/include/uapi/asm/ptrace.h                 |    1 +
 arch/arm/mach-shmobile/Makefile                    |    1 +
 arch/arm/mach-shmobile/common.h                    |    2 +
 arch/arm/mach-shmobile/headsmp-apmu.S              |   37 +
 arch/arm/mach-shmobile/headsmp.S                   |   20 +-
 arch/arm/mach-shmobile/platsmp-apmu.c              |    2 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |    3 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   30 +-
 drivers/clk/shmobile/clk-rcar-gen2.c               |   24 +-
 drivers/gpio/gpio-rcar.c                           |    6 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   23 +
 drivers/of/base.c                                  |   22 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/core.h                      |    1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               | 2516 +++++++++++++++-----
 include/dt-bindings/clock/r8a7745-clock.h          |  147 ++
 include/linux/of.h                                 |    2 +
 36 files changed, 3984 insertions(+), 702 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7745.dtsi
 create mode 100644 arch/arm/mach-shmobile/headsmp-apmu.S
 create mode 100644 include/dt-bindings/clock/r8a7745-clock.h

-- 
2.7.4
