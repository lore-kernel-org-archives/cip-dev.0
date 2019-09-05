From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  5 Sep 2019 09:37:11 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip repost 0/6] Add eMMC/uSD/LEDs support
	to HiHope RZ/G2M
Message-ID: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear All,

This series is to add eMMC/uSD/LEDs support to the HiHope RZ/G2M board,
and depends on series:
https://patchwork.kernel.org/cover/11126905/

Thanks,
Fab

Fabrizio Castro (3):
  arm64: dts: renesas: hihope-common: Add uSD and eMMC
  arm64: dts: renesas: hihope-common: Add LEDs support
  arm64: dts: renesas: hihope-common: Remove "label" from LEDs

Takeshi Saito (1):
  mmc: renesas_sdhi: Change HW adjustment register according to speed
    mode

Wolfram Sang (2):
  mmc: tmio: introduce macro for max block size
  mmc: renesas_sdhi: prevent overflow for max_req_size

 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 97 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi.h                |  2 +
 drivers/mmc/host/renesas_sdhi_core.c           |  8 +++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c  |  9 +--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c       |  2 +-
 drivers/mmc/host/tmio_mmc.h                    |  2 +
 drivers/mmc/host/tmio_mmc_core.c               |  2 +-
 7 files changed, 116 insertions(+), 6 deletions(-)

-- 
2.7.4
