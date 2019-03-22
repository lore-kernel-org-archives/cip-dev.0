From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:19:21 +0000
Subject: [cip-dev] [PATCH 0/9] Add SMP/INTC-EX/PFC/GPIO support
Message-ID: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add SMP/INTC-EX/PFC/GPIO support
for RZ/G2E SoC.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=94967

Biju Das (1):
  arm64: dts: renesas: r8a774c0-cat874: Add pincontrol support to scif2

Fabrizio Castro (6):
  arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU core
  arm64: dts: renesas: r8a774c0: Add INTC-EX device node
  arm64: dts: renesas: r8a774c0: Add PFC support
  dt-bindings: gpio: rcar: Add r8a774a1 (RZ/G2M) support
  dt-bindings: gpio: rcar: Add r8a774c0 (RZ/G2E) support
  arm64: dts: renesas: r8a774c0: Add GPIO device nodes

Geert Uytterhoeven (2):
  pinctrl: sh-pfc: rcar: Rename automotive-only arrays to automotive
  pinctrl: sh-pfc: r8a77990: Add INTC-EX pins, groups and function

 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   4 +-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    |  10 ++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 151 +++++++++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |  16 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  12 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              |  72 +++++++++-
 6 files changed, 236 insertions(+), 29 deletions(-)

-- 
2.7.4
