From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:29:53 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/12] Renesas RZ/G2N extend peripheral
	support
Message-ID: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series adds support for following peripherals supported by RZ
G2N,
1: SDHI
2: Watchdog
3: MSIOF
4: PCIE

Please note this patch series is based on top of the series [1].

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=233689&submitter=&state=*&q=&archive=both&delegate=

Biju Das (3):
  mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add SDHI support
  arm64: dts: renesas: r8a774b1-hihope-rzg2n: Enable HS400 mode

Fabrizio Castro (7):
  dt-bindings: spi: sh-msiof: Add r8a774b1 support
  dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add RWDT node
  arm64: dts: renesas: r8a774b1: Add all MSIOF nodes
  arm64: dts: renesas: r8a774b1: Add PCIe device nodes
  arm64: dts: renesas: hihope-rzg2-ex: Let the board specific DT decide
    about pciec1
  arm64: dts: renesas: r8a774b1: Add INTC-EX device node

Lad Prabhakar (1):
  dt-bindings: mmc: renesas_sdhi: Add r8a774b1 support

Simon Horman (1):
  dt-bindings: watchdog: Rename bindings documentation file

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |  46 ++++++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  45 ------
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |   4 -
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  |   4 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n.dts     |   4 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 163 ++++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   1 +
 9 files changed, 213 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt

-- 
2.7.4
