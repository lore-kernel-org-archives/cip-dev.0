From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Mon, 27 Jan 2020 14:25:49 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 0/8] Renesas RZ/G2N extend peripheral
	support
Message-ID: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series adds support for following peripherals supported by RZ/G2N,
along with adding support for HiHope RZ/G2N sub board
1: DMAC
2: SCIF/HSCIF
3: GPIO controller
4: Ethernet controller

Biju Das (8):
  dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings
  arm64: dts: renesas: r8a774b1: Add SYS-DMAC device nodes
  arm64: dts: renesas: r8a774b1: Add SCIF and HSCIF nodes
  dt-bindings: gpio: rcar: Add DT binding for r8a774b1
  arm64: dts: renesas: r8a774b1: Add GPIO device nodes
  dt-bindings: net: ravb: Add support for r8a774b1 SoC
  arm64: dts: renesas: r8a774b1: Add Ethernet AVB node
  arm64: dts: renesas: Add HiHope RZ/G2N sub board support

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 .../boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts  |  15 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 381 ++++++++++++++++++++-
 6 files changed, 389 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts

-- 
2.7.4
