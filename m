From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
Message-ID: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add SD/eMMC support support for RZ/G1C sbc.

RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an 
internal DMA for data transfer which is similar to R-Car Gen3.

Support for internal DMAC is added in 4.14 kernel and support for 
RZ/G1C added on 4.20 kernel.

Backported the relevent patches to linux-4.4.y-cip.

This patch series is based on linux-4.4.y-cip and all the patches
in this series are cherry-picked from linux rc tree.

Ai Kyuse (3):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add hw reset support
  mmc: tmio: Add tuning support

Arnd Bergmann (1):
  mmc: tmio_mmc_dma: don't print invalid DMA cookie

Ben Hutchings (2):
  mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to clk_{enable,
    disable} ops
  mmc: tmio, sh_mobile_sdhi: Add support for variable input clock
    frequency

Chris Brandt (3):
  mmc: tmio-mmc: add support for 32bit data port
  mmc: sh_mobile_sdhi: add ocr_mask option
  mmc: tmio-mmc: fix bad pointer math

Fabrizio Castro (6):
  dt-bindings: mmc: renesas_sdhi: Add r8a77470 support
  mmc: renesas_sdhi: Add r8a77470 SDHI1 support
  ARM: dts: r8a77470: Add SDHI2 support
  ARM: dts: r8a77470: Add SDHI0 support
  ARM: dts: r8a77470: Add SDHI1 support
  ARM: dts: iwg23s-sbc: Add uSD and eMMC support

Masaharu Hayakawa (1):
  mmc: tmio: always get number of taps

Masahiro Yamada (1):
  mmc: renesas_sdhi: consolidate DMAC CONFIG options

Simon Horman (14):
  mmc: tmio: document mandatory and optional callbacks
  mmc: core: Add helper to see if a host can be retuned
  mmc: sh_mobile_sdhi: Add tuning support
  mmc: tmio: drop filenames from comment at top of source
  mmc: renesas-sdhi, tmio: make dma more modular
  mmc: tmio: rename tmio_mmc_{pio => core}.c
  mmc: renesas-sdhi: rename tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
  mmc: renesas-sdhi: rename sh_mobile_sdhi.c => renesas_sdhi_core.c
  mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file
  mmc: renesas-sdhi: improve checkpatch cleanness
  mmc: tmio, renesas-sdhi: add dataend to DMA ops
  mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
  dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123] fallback
    compatibility strings
  mmc: renesas_sdhi: implement R-Car Gen[123] fallback compatibility
    strings

Ulf Hansson (2):
  mmc: tmio: Remove redundant runtime PM calls
  mmc: tmio: Remove redundant check of mmc->slot.cd_irq

Wolfram Sang (49):
  mmc: tmio_dma: remove debug messages with little information
  mmc: tmio: add flag to reduce delay after changing clock status
  mmc: tmio: remove stale comments
  mmc: tmio: refactor set_clock a little
  mmc: tmio: disable clock before changing it
  mmc: sdhi: use faster clock handling on RCar Gen2
  mmc: sdhi: error message on ENOMEM is superfluous
  mmc: sdhi: Add r8a7795 support
  mmc: tmio: Add UHS-I mode support
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  mmc: tmio: always start clock after frequency calculation
  mmc: tmio: stop clock when 0Hz is requested
  mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
  mmc: tmio: remove now unneeded seperate irq handlers
  mmc: tmio: simplify irq handler
  mmc: tmio: merge distributed include files
  mmc: tmio: give read32/write32 functions more descriptive names
  mmc: tmio: use BIT() within defines
  mmc: tmio: use CTL_STATUS consistently
  mmc: tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC
  mmc: tmio: document CTL_STATUS handling
  mmc: tmio/sdhi: introduce flag for RCar 2+ specific features
  mmc: sh_mobile_sdhi: make clk_update function more compact
  mmc: sh_mobile_sdhi: only change the clock on RCar Gen2+
  mmc: sh_mobile_sdhi: check return value when changing clk
  mmc: sh_mobile_sdhi: properly document R-Car versions
  mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
  mmc: host: sh_mobile_sdhi: don't populate unneeded functions
  mmc: tmio: add eMMC support
  mmc: add define for R1 response without CRC
  mmc: tmio: fix wrong bitmask for SDIO irqs
  mmc: tmio: remove SDIO from TODO list
  mmc: tmio: use SDIO master interrupt bit only when allowed
  mmc: sh_mobile_sdhi: simplify accessing DT data
  mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
  mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
  mmc: sh_mobile_sdhi: improve prerequisites for tuning
  mmc: sh_mobile_sdhi: remove superfluous check in SCC error check
  mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
  mmc: sh_mobile_sdhi: enable HS200
  mmc: host: tmio: drop superfluous exit path
  mmc: host: tmio: disable clocks when unbinding
  mmc: host: tmio: refactor calls to sdio irq
  mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
  mmc: tmio: discard obsolete SDIO irqs before enabling irqs
  mmc: tmio: ensure end of DMA and SD access are in sync
  mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
  mmc: host: tmio: don't BUG on unsupported stop commands
  mmc: host: tmio: fill in response from auto cmd12

Yoshihiro Shimoda (1):
  mmc: tmio, renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   12 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |   75 ++
 arch/arm/boot/dts/r8a77470.dtsi                    |   38 +
 drivers/mmc/host/Kconfig                           |   21 +-
 drivers/mmc/host/Makefile                          |    6 +-
 drivers/mmc/host/renesas_sdhi.h                    |   41 +
 drivers/mmc/host/renesas_sdhi_core.c               |  632 +++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  273 ++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  480 +++++++
 drivers/mmc/host/sh_mobile_sdhi.c                  |  397 ------
 drivers/mmc/host/tmio_mmc.c                        |   10 +-
 drivers/mmc/host/tmio_mmc.h                        |  170 ++-
 drivers/mmc/host/tmio_mmc_core.c                   | 1399 ++++++++++++++++++++
 drivers/mmc/host/tmio_mmc_dma.c                    |  356 -----
 drivers/mmc/host/tmio_mmc_pio.c                    | 1275 ------------------
 include/linux/mfd/tmio.h                           |   13 +-
 include/linux/mmc/core.h                           |    3 +
 include/linux/mmc/host.h                           |    5 +
 include/linux/mmc/tmio.h                           |   66 -
 19 files changed, 3120 insertions(+), 2152 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 create mode 100644 drivers/mmc/host/renesas_sdhi_core.c
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
 create mode 100644 drivers/mmc/host/renesas_sdhi_sys_dmac.c
 delete mode 100644 drivers/mmc/host/sh_mobile_sdhi.c
 create mode 100644 drivers/mmc/host/tmio_mmc_core.c
 delete mode 100644 drivers/mmc/host/tmio_mmc_dma.c
 delete mode 100644 drivers/mmc/host/tmio_mmc_pio.c
 delete mode 100644 include/linux/mmc/tmio.h

-- 
2.7.4
