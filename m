From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:16 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/21] Add iWave RZ/G1N support
Message-ID: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add support for iWave G20D-Q7 board based on RZ/G1N.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (20):
  dt-bindings: reset: rcar-rst: Document r8a7744 reset module
  soc: renesas: rcar-rst: Add support for RZ/G1N
  ARM: shmobile: r8a7744: Add clock index macros for DT sources
  clk: shmobile: Compile clk-rcar-gen2.c when using the r8a7744
  ARM: shmobile: r8a7744: Basic SoC support
  clk: shmobile: Document r8a7744 CPG clock support
  clk: shmobile: Document r8a7744 MSTP clock support
  clk: shmobile: Document r8a7744 CPG DIV6 clock support
  ARM: multi_v7_defconfig: Enable r8a7744 SoC
  ARM: shmobile: defconfig: Enable r8a7744 SoC
  ARM: debug-ll: Add support for r8a7744
  dt-bindings: pinctrl: sh-pfc: Document r8a7744 PFC support
  pinctrl: sh-pfc: r8a7791: Add r8a7744 support
  ARM: dts: iwg20d-q7-common: Move pciec node out of common dtsi
  dt-bindings: serial: sh-sci: Document r8a7744 bindings
  ARM: dts: r8a7744: Initial SoC device tree
  dt-bindings: arm: renesas: Document iWave RZ/G1N SOM
  dt-bindings: arm: renesas: Document iW-RainboW-G20D-Qseven-RZG1N board
  ARM: dts: r8a7744-iwg20m: Add iWave RZ/G1N Qseven SOM
  ARM: dts: r8a7744-iwg20d-q7: Add support for iWave G20D-Q7 board based
    on RZ/G1N

Geert Uytterhoeven (1):
  ARM: shmobile: Document RZ/G1N SoC DT binding

 Documentation/devicetree/bindings/arm/shmobile.txt |   6 +
 .../bindings/clock/renesas,cpg-div6-clocks.txt     |   1 +
 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         |   1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |   1 +
 .../bindings/serial/renesas,sci-serial.txt         |   4 +
 arch/arm/Kconfig.debug                             |   7 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   4 -
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts    |   4 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |   4 +
 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts            |  15 +
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi              |  31 +
 arch/arm/boot/dts/r8a7744.dtsi                     | 778 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/shmobile_defconfig                |   1 +
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   2 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   1 +
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |   5 +
 drivers/pinctrl/sh-pfc/Makefile                    |   1 +
 drivers/pinctrl/sh-pfc/core.c                      |   6 +
 drivers/pinctrl/sh-pfc/core.h                      |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  21 +
 drivers/soc/renesas/rcar-rst.c                     |   1 +
 include/dt-bindings/clock/r8a7744-clock.h          | 166 +++++
 28 files changed, 1064 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7744.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7744-clock.h

-- 
2.7.4
