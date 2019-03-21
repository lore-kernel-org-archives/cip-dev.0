From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:11:59 +0000
Subject: [cip-dev] [PATCH 0/9] Add RZ/G2[ME] Clock support
Message-ID: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series aims to add Clock support for RZ/G2[ME] SoCs.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

This patch series is depend on the below patch series
https://patchwork.kernel.org/project/cip-dev/list/?series=94893

Biju Das (2):
  clk: renesas: Add r8a774a1 CPG Core Clock Definitions
  clk: renesas: cpg-mssr: Add r8a774a1 support

Fabrizio Castro (3):
  clk: renesas: Add r8a774c0 CPG Core Clock Definitions
  dt-bindings: clock: renesas: cpg-mssr: Document r8a774c0
  clk: renesas: cpg-mssr: Add r8a774c0 support

Geert Uytterhoeven (4):
  clk: renesas: rcar-gen3: Add support for OSC EXTAL predivider
  clk: renesas: cpg-mssr: Add support for fixed rate clocks
  clk: renesas: rcar-gen3: Add support for RCKSEL clock selection
  clk: renesas: rcar-gen3: Add support for mode pin clock selection

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |  10 +-
 drivers/clk/renesas/Kconfig                        |  10 +
 drivers/clk/renesas/Makefile                       |   2 +
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            | 323 +++++++++++++++++++++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            | 286 ++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.c                |  40 ++-
 drivers/clk/renesas/rcar-gen3-cpg.h                |  24 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |  17 ++
 drivers/clk/renesas/renesas-cpg-mssr.h             |   5 +
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h      |  58 ++++
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      |  60 ++++
 11 files changed, 817 insertions(+), 18 deletions(-)
 create mode 100644 drivers/clk/renesas/r8a774a1-cpg-mssr.c
 create mode 100644 drivers/clk/renesas/r8a774c0-cpg-mssr.c
 create mode 100644 include/dt-bindings/clock/r8a774a1-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a774c0-cpg-mssr.h

-- 
2.7.4
