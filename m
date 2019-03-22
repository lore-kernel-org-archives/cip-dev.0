From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:39:59 +0000
Subject: [cip-dev] [PATCH 00/11] Add SDHI support
Message-ID: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add SDHI support for EK874 platform.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=95321

Biju Das (2):
  mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0
  arm64: dts: renesas: r8a774c0-cat874: Add uSD support

Fabrizio Castro (5):
  mmc: renesas_sdhi: Add r8a774a1 support
  mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
  dt-bindings: mmc: renesas_sdhi: Add r8a77470 support
  dt-bindings: mmc: renesas_sdhi: Add r8a774c0 support
  arm64: dts: renesas: r8a774c0: Add SDHI nodes

Takeshi Kihara (4):
  pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add SDHI pins, groups and functions
  pinctrl: sh-pfc: r8a77990: Add voltage switch operations for SDHI

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   9 +-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  50 ++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |  36 ++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   2 +
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              | 692 ++++++++++++++++++++-
 5 files changed, 783 insertions(+), 6 deletions(-)

-- 
2.7.4
