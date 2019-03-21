From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 16:22:09 +0000
Subject: [cip-dev] [PATCH 00/10] Add basic RZ/G2E SoC/EK874 support
Message-ID: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add support for RZ/G2E SoC and EK874
platform.

The EK874 is an evaluation kit for the RZ/G2E SoC (a.k.a. r8a774c0)
from Silicon Linux Corporation. It is made of two boards: cat874
(the main board) and cat875 (the sub board).

This series adds the device trees to describe the SoC/HW configuration
of the R8A774C0 SoC/EK874 platform, with some basic support.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=94939


Biju Das (3):
  dt-bindings: arm: Add si-linux cat87[45] boards
  arm64: dts: renesas: Add Si-Linux CAT874 board support
  arm64: dts: renesas: Add Si-Linux EK874 board support

Fabrizio Castro (7):
  arm64: dts: renesas: Initial device tree for r8a774c0
  dmaengine: rcar-dmac: Document R8A774A1 bindings
  dmaengine: rcar-dmac: Document R8A774C0 bindings
  arm64: dts: renesas: r8a774c0: Add SYS-DMAC controller nodes
  dt-bindings: serial: sh-sci: Document r8a774a1 bindings
  dt-bindings: serial: sh-sci: Document r8a774c0 bindings
  arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   4 +-
 .../bindings/serial/renesas,sci-serial.txt         |  16 +-
 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 arch/arm64/boot/dts/renesas/cat875.dtsi            |  10 +
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  37 ++
 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts     |  14 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 459 +++++++++++++++++++++
 8 files changed, 538 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/cat875.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0.dtsi

-- 
2.7.4
