From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:18 +0100
Subject: [cip-dev] [PATCH 00/42] Add watchdog support to iwg20m and iwg22m
Message-ID: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

this series backports watchdog support for iwg20m and iwg22m.

There is a dependency with series:
https://lists.cip-project.org/pipermail/cip-dev/2018-July/001415.html

This work is based on top of linux-4.4.y-cip, commit
4d769b2b8749e89dfc7ea179a44f652dcfbedb37 ("PM / OPP: Move error
message to debug level").

Thanks,
Fab

Fabrizio Castro (15):
  ARM: shmobile: Remove shmobile_boot_arg from
    shmobile_smp_apmu_setup_boot
  ARM: shmobile: Add watchdog support
  clk: shmobile: rcar-gen2: Init R-Car reset IP
  ARM: dts: r8a7743: Register rwdt and intc-sys clocks
  ARM: dts: r8a7745: Register rwdt and intc-sys clocks
  watchdog: renesas_wdt: Add suspend/resume support
  watchdog: renesas_wdt: Add restart handler
  ARM: shmobile: rcar-gen2: Add watchdog support
  ARM: dts: r8a7743: Adjust SMP routine size
  ARM: dts: r8a7745: Adjust SMP routine size
  ARM: dts: r8a7743: Add watchdog support to SoC dtsi
  ARM: dts: r8a7745: Add watchdog support to SoC dtsi
  ARM: dts: iwg20m: Add watchdog support to SoM dtsi
  ARM: dts: iwg22m: Add watchdog support to SoM dtsi
  ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN

Geert Uytterhoeven (12):
  ARM: shmobile: Remove shmobile_boot_arg
  ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup
    code
  soc: renesas: Add R-Car RST driver
  reset: Add renesas,rst DT bindings
  clk: renesas: mstp: Make INTC-SYS a critical clock
  ARM: shmobile: rcar-gen2: Add more register documentation
  ARM: shmobile: rcar-gen2: Use ICRAM1 for jump stub on all SoCs
  ARM: shmobile: rcar-gen2: Obtain jump stub region from DT
  ARM: dts: r8a7743: Add Inter Connect RAM
  ARM: dts: r8a7743: Reserve SRAM for the SMP jump stub
  ARM: dts: r8a7745: Add Inter Connect RAM
  ARM: dts: r8a7745: Reserve SRAM for the SMP jump stub

Lee Jones (2):
  clk: Allow clocks to be marked as CRITICAL
  clk: WARN_ON about to disable a critical clock

Maxime Ripard (1):
  clk: fix critical clock locking

Sergei Shtylyov (2):
  ARM: dts: r8a7743: initial SoC device tree
  ARM: dts: r8a7745: initial SoC device tree

Veeraiyan Chidambaram (1):
  watchdog: renesas-wdt: Add support for WDIOF_CARDRESET

Wolfram Sang (9):
  watchdog: renesas-wdt: add driver
  watchdog: renesas_wdt: avoid (theoretical) type overflow
  watchdog: renesas_wdt: check rate also for upper limit
  watchdog: renesas_wdt: don't round closest with get_timeleft
  watchdog: renesas_wdt: apply better precision
  watchdog: renesas_wdt: add another divider option
  watchdog: renesas_wdt: consistently use RuntimePM for clock management
  watchdog: renesas_wdt: make 'clk' a variable local to probe()
  watchdog: renesas_wdt: update copyright dates

 .../devicetree/bindings/reset/renesas,rst.txt      |  24 ++
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  33 +++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |   5 +
 arch/arm/boot/dts/r8a7743.dtsi                     |  46 +++-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |   5 +
 arch/arm/boot/dts/r8a7745.dtsi                     |  44 +++-
 arch/arm/configs/shmobile_defconfig                |   1 +
 arch/arm/mach-shmobile/common.h                    |   5 +-
 arch/arm/mach-shmobile/headsmp.S                   |  63 ++++-
 arch/arm/mach-shmobile/platsmp-apmu.c              |   3 +-
 arch/arm/mach-shmobile/platsmp-scu.c               |   1 -
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  97 +++++--
 arch/arm/mach-shmobile/smp-r8a7779.c               |   2 -
 drivers/clk/clk.c                                  |  16 ++
 drivers/clk/shmobile/clk-mstp.c                    |   5 +
 drivers/clk/shmobile/clk-rcar-gen2.c               |   3 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/renesas/Makefile                       |   1 +
 drivers/soc/renesas/rcar-rst.c                     |  81 ++++++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_wdt.c                     | 285 +++++++++++++++++++++
 include/linux/clk-provider.h                       |   1 +
 include/linux/soc/renesas/rcar-rst.h               |   6 +
 24 files changed, 694 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
 create mode 100644 drivers/soc/renesas/Makefile
 create mode 100644 drivers/soc/renesas/rcar-rst.c
 create mode 100644 drivers/watchdog/renesas_wdt.c
 create mode 100644 include/linux/soc/renesas/rcar-rst.h

-- 
2.7.4
