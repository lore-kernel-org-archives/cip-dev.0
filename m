From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 00/17] Add RZ/G1C SD/eMMC support
Message-ID: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch series add SD/eMMC support support for RZ/G1C sbc.

RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an 
internal DMA for data transfer which is similar to R-Car Gen3.

Support for internal DMAC is added in 4.14 kernel and support for 
RZ/G1C added on 4.20 kernel.

Backported the relevent patches to linux-4.4.y-cip.

Fabrizio Castro (6):
  dt-bindings: mmc: renesas_sdhi: Add r8a77470 support
  mmc: renesas_sdhi: Add r8a77470 SDHI1 support
  ARM: dts: r8a77470: Add SDHI2 support
  ARM: dts: r8a77470: Add SDHI0 support
  ARM: dts: r8a77470: Add SDHI1 support
  ARM: dts: iwg23s-sbc: Add uSD and eMMC support

Masahiro Yamada (1):
  mmc: renesas_sdhi: consolidate DMAC CONFIG options

Simon Horman (9):
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

Yoshihiro Shimoda (1):
  mmc: tmio, renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |    9 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |   75 ++
 arch/arm/boot/dts/r8a77470.dtsi                    |   38 +
 drivers/mmc/host/Kconfig                           |   21 +-
 drivers/mmc/host/Makefile                          |    5 +-
 drivers/mmc/host/renesas_sdhi.h                    |   41 +
 drivers/mmc/host/renesas_sdhi_core.c               |  632 +++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  273 ++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  480 +++++++
 drivers/mmc/host/sh_mobile_sdhi.c                  |  745 -----------
 drivers/mmc/host/tmio_mmc.h                        |   11 +-
 drivers/mmc/host/tmio_mmc_core.c                   | 1398 ++++++++++++++++++++
 drivers/mmc/host/tmio_mmc_dma.c                    |  365 -----
 drivers/mmc/host/tmio_mmc_pio.c                    | 1392 -------------------
 include/linux/mfd/tmio.h                           |    2 +
 15 files changed, 2973 insertions(+), 2514 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 create mode 100644 drivers/mmc/host/renesas_sdhi_core.c
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
 create mode 100644 drivers/mmc/host/renesas_sdhi_sys_dmac.c
 delete mode 100644 drivers/mmc/host/sh_mobile_sdhi.c
 create mode 100644 drivers/mmc/host/tmio_mmc_core.c
 delete mode 100644 drivers/mmc/host/tmio_mmc_dma.c
 delete mode 100644 drivers/mmc/host/tmio_mmc_pio.c

-- 
2.7.4
