From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 00/23] Clock enhancements
Message-ID: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add OPP tables,HS400 quirk for SD clock,
add support  Z2 clock and fix some of parent clocks.

This patch series is based on linux-4.19.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Biju Das (2):
  clk: renesas: rcar-gen3: Parameterise Z and Z2 clock fixed divisor
  clk: renesas: rcar-gen3: Parameterise Z and Z2 clock offset

Fabrizio Castro (3):
  clk: renesas: r8a774a1: Add missing CANFD clock
  clk: renesas: r8a774a1: Fix LAST_DT_CORE_CLK
  arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices

Geert Uytterhoeven (2):
  clk: renesas: r8a774a1: Add CPEX clock
  clk: renesas: rcar-gen3: Pass name/offset to cpg_sd_clk_register()

Kazuya Mizuguchi (2):
  clk: renesas: rcar-gen3: Correct parent clock of EHCI/OHCI
  clk: renesas: rcar-gen3: Correct parent clock of HS-USB

Niklas S?derlund (3):
  clk: renesas: rcar-gen3: Set state when registering SD clocks
  clk: renesas: rcar-gen3: Add documentation for SD clocks
  clk: renesas: rcar-gen3: Add HS400 quirk for SD clock

Sergei Shtylyov (2):
  clk: renesas: rcar-gen3: Factor out cpg_reg_modify()
  clk: renesas: rcar-gen3: Add spinlock

Simon Horman (4):
  clk: renesas: rcar-gen3: Remove CLK_TYPE_GEN3_Z2
  math64: New DIV64_U64_ROUND_CLOSEST helper
  clk: renesas: rcar-gen3: Support Z and Z2 clocks with high frequency
    parents
  clk: renesas: r8a774c0: Add Z2 clock

Stephen Boyd (2):
  clk: renesas: Remove usage of CLK_IS_BASIC
  clk: renesas: rcar-gen3: Remove unused variable

Takeshi Kihara (3):
  clk: renesas: rcar-gen3: Correct parent clock of SYS-DMAC
  clk: renesas: rcar-gen3: Correct parent clock of Audio-DMAC
  clk: renesas: rcar-gen3: Fix cpg_sd_clock_round_rate() return value

 arch/arm64/boot/dts/renesas/r8a774c0.dtsi     |  25 ++++
 drivers/clk/renesas/clk-div6.c                |   2 +-
 drivers/clk/renesas/clk-mstp.c                |   2 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c       |  23 ++--
 drivers/clk/renesas/r8a774c0-cpg-mssr.c       |   7 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c        |  25 ++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c        |  19 +--
 drivers/clk/renesas/r8a77965-cpg-mssr.c       |  16 +--
 drivers/clk/renesas/r8a77990-cpg-mssr.c       |   6 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c       |   2 +-
 drivers/clk/renesas/rcar-gen3-cpg.c           | 174 ++++++++++++++------------
 drivers/clk/renesas/rcar-gen3-cpg.h           |   5 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |   2 +-
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h |   1 +
 include/linux/math64.h                        |  13 ++
 15 files changed, 193 insertions(+), 129 deletions(-)

-- 
2.7.4
