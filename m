From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:57:59 +0100
Subject: [cip-dev] [PATCH 4.19.y 00/17] Add CMT and TMU support to RZ/G2E
Message-ID: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

this series backports what's necessary to support CMT and TMU
on the RZ/G2E.

This series depends on:
https://patchwork.kernel.org/project/cip-dev/list/?series=98481

Thanks,
Fab

Biju Das (5):
  dt-bindings: timer: renesas, cmt: Document r8a774a1 CMT support
  dt-bindings: timer: renesas, cmt: Document r8a774c0 CMT support
  arm64: dts: renesas: r8a774c0: Add CMT device nodes
  clk: renesas: r8a774c0: Add TMU clock
  dt-bindings: timer: renesas: tmu: Document r8a774c0 bindings

Fabrizio Castro (3):
  clk: renesas: r8a774c0: Add missing CANFD clock
  clk: renesas: r8a774c0: Fix LAST_DT_CORE_CLK
  arm64: dts: renesas: r8a774c0: Add TMU device nodes

Geert Uytterhoeven (1):
  clk: renesas: r8a774c0: Correct parent clock of DU

Kuninori Morimoto (2):
  clocksource/drivers/sh_cmt: Convert to SPDX identifiers
  clocksource/drivers/sh_tmu: Convert to SPDX identifiers

Sergei Shtylyov (6):
  clocksource/drivers/sh_cmt: Fixup for 64-bit machines
  clocksource/drivers/sh_cmt: Fix clocksource width for 32-bit machines
  clocksource/drivers/sh_cmt: Properly line-wrap sh_cmt_of_table[]
    initializer
  dt-bindings: timer: renesas: cmt: document R-Car gen3 support
  clocksource/drivers/sh_cmt: Add R-Car gen3 support
  arm64: enable CMT/TMU support for Renesas SoC

 .../devicetree/bindings/timer/renesas,cmt.txt      |  14 +++
 .../devicetree/bindings/timer/renesas,tmu.txt      |   1 +
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 135 +++++++++++++++++++++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |  15 ++-
 drivers/clocksource/sh_cmt.c                       | 106 ++++++++--------
 drivers/clocksource/sh_tmu.c                       |  10 +-
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      |   1 +
 8 files changed, 219 insertions(+), 65 deletions(-)

-- 
2.7.4
