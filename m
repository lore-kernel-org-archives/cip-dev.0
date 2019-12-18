From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:10 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/39] Add RZ/G2N SYSC/RST/Clock/PFC
	support
Message-ID: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add support for RZ/G2N board with serial debug console.

Biju Das (18):
  dt-bindings: arm: renesas: Document RZ/G2N SoC DT bindings
  dt-bindings: arm: renesas: Add HopeRun RZ/G2N boards
  soc: renesas: Add Renesas R8A774B1 config option
  soc: renesas: Identify RZ/G2N
  dt-bindings: power: Add r8a774b1 SYSC power domain definitions
  dt-bindings: power: rcar-sysc: Document r8a774b1 sysc
  soc: renesas: rcar-sysc: Add r8a774b1 support
  dt-bindings: reset: rcar-rst: Document r8a774b1 reset module
  soc: renesas: rcar-rst: Add support for RZ/G2N
  dt-bindings: clk: Add r8a774b1 CPG Core Clock Definitions
  dt-bindings: clock: renesas: cpg-mssr: Document r8a774b1 binding
  clk: renesas: cpg-mssr: Add r8a774b1 support
  dt-bindings: pinctrl: sh-pfc: Document r8a774b1 PFC support
  pinctrl: sh-pfc: r8a77965: Add R8A774B1 PFC support
  dt-bindings: serial: sh-sci: Document r8a774b1 bindings
  arm64: dts: renesas: Initial r8a774b1 SoC device tree
  arm64: dts: renesas: Add HiHope RZ/G2N main board support
  arm64: defconfig: Enable R8A774B1 SoC

Geert Uytterhoeven (11):
  soc: renesas: rcar-sysc: Prepare for fixing power request conflicts
  soc: renesas: r8a7795-sysc: Fix power request conflicts
  soc: renesas: r8a7796-sysc: Fix power request conflicts
  soc: renesas: r8a77965-sysc: Fix power request conflicts
  soc: renesas: r8a77970-sysc: Fix power request conflicts
  soc: renesas: r8a77980-sysc: Fix power request conflicts
  soc: renesas: r8a77990-sysc: Fix power request conflicts
  soc: renesas: r8a774c0-sysc: Fix power request conflicts
  pinctrl: sh-pfc: r8a77965: Replace DU_DOTCLKIN2 by DU_DOTCLKIN3
  pinctrl: sh-pfc: r8a77965: Add TPU pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Use new macros for non-GPIO pins

Hoan Nguyen An (2):
  pinctrl: sh-pfc: r8a77965: Add Audio clock pin support
  pinctrl: sh-pfc: r8a77965: Add Audio SSI pin support

Jacopo Mondi (1):
  pinctrl: sh-pfc: r8a77965: Add VIN[4|5] groups/functions

Keiya Nobuta (1):
  pinctrl: sh-pfc: pfc-r8a77965: Fix typo in pinmux macro for SCL3

Takeshi Kihara (6):
  pinctrl: sh-pfc: r8a77965: Add SATA pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Add CAN pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Add CAN FD pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Add TMU pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Add DRIF pins, groups and functions
  pinctrl: sh-pfc: r8a77965: Add I2C{0,3,5} pins, groups and functions

 Documentation/devicetree/bindings/arm/shmobile.txt |    9 +-
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   10 +-
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 .../bindings/power/renesas,rcar-sysc.txt           |    1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |    1 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 arch/arm64/Kconfig.platforms                       |    6 +
 arch/arm64/boot/dts/renesas/Makefile               |    1 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts     |   26 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |  472 +++++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |  322 +++
 drivers/clk/renesas/renesas-cpg-mssr.c             |    6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 2234 ++++++++++++++++----
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
 drivers/soc/renesas/Kconfig                        |   12 +-
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/r8a774b1-sysc.c                |   37 +
 drivers/soc/renesas/r8a774c0-sysc.c                |    3 +
 drivers/soc/renesas/r8a7795-sysc.c                 |   32 +-
 drivers/soc/renesas/r8a7796-sysc.c                 |   22 +-
 drivers/soc/renesas/r8a77965-sysc.c                |    3 +
 drivers/soc/renesas/r8a77970-sysc.c                |    3 +
 drivers/soc/renesas/r8a77980-sysc.c                |    3 +
 drivers/soc/renesas/r8a77990-sysc.c                |    3 +
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 drivers/soc/renesas/rcar-sysc.c                    |   19 +
 drivers/soc/renesas/rcar-sysc.h                    |    8 +-
 drivers/soc/renesas/renesas-soc.c                  |    8 +
 include/dt-bindings/clock/r8a774b1-cpg-mssr.h      |   57 +
 include/dt-bindings/power/r8a774b1-sysc.h          |   26 +
 37 files changed, 2881 insertions(+), 469 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1.dtsi
 create mode 100644 drivers/clk/renesas/r8a774b1-cpg-mssr.c
 create mode 100644 drivers/soc/renesas/r8a774b1-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a774b1-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774b1-sysc.h

-- 
2.7.4
