From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:10 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 00/12] Renesas RZ/G2E backport IPA
	support along with minor fixes
Message-ID: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series intends to do the following:
1: Add IPA support
2: Update the CAN bindings
3: Fix display node range
4: Minor tweaks for sorting the nodes
5: Use any protocol available in kernel for ip instead of dhcp
6: Cleanup CPU compatibles

This patch series is based on linux-4.19.y-cip and all the patches in this
series are cherry-picked from upstream.

Biju Das (2):
  arm64: dts: renesas: r8a774c0: Create thermal zone to support IPA
  arm64: dts: renesas: r8a774c0: Add dynamic power coefficient

Eugeniu Rosca (1):
  dt-bindings: can: rcar_can: document r8a77965 support

Fabrizio Castro (3):
  dt-bindings: can: rcar_can: Complete documentation for RZ/G2[EM]
  arm64: dts: renesas: r8a774c0: Add missing assigned-clocks for CAN[01]
  arm64: dts: renesas: r8a774c0: cat874: Add definition for 12V
    regulator

Geert Uytterhoeven (1):
  arm64: dts: renesas: r8a774c0: Fix register range of display node

Jacopo Mondi (1):
  arm64: dts: renesas: Update 'vsps' properties for readability

Magnus Damm (1):
  arm64: dts: renesas: Use ip=on for bootargs

Robin Murphy (1):
  arm64: dts: renesas: r8a774c0: Clean up CPU compatibles

Yoshihiro Kaneko (2):
  thermal: rcar_thermal: update calculation formula for R-Car Gen3 SoCs
  arm64: dts: renesas: r8a774c0: cat874: Sort nodes

 .../devicetree/bindings/net/can/rcar_can.txt       |  9 +++--
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    | 39 +++++++++++++---------
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 36 +++++++++++++++-----
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  2 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  2 +-
 drivers/thermal/rcar_thermal.c                     | 11 +++++-
 9 files changed, 70 insertions(+), 35 deletions(-)

-- 
2.7.4
