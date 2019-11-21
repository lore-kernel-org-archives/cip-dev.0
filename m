From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Thu, 21 Nov 2019 10:13:38 +0900
Subject: [cip-dev] [PATCH 4.4.y-cip 00/31] Add RZ/G1C SD/eMMC support
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CABMQnVK0AE8Z2K=211qLwxAi5rkSEwu=6aXpzDiCu6ZPOgma1A@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Biju,

2019?11?19?(?) 22:42 Biju Das <biju.das@bp.renesas.com>:
>
> This patch series add SD/eMMC support support for RZ/G1C sbc.
>
> RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an
> internal DMA for data transfer which is similar to R-Car Gen3.
>
> Support for internal DMAC is added in 4.14 kernel and support for
> RZ/G1C added on 4.20 kernel.
>
> Backported the relevent patches to linux-4.4.y-cip.
>
> This patch series is based on linux-4.4.y-cip and all the patches
> in this series are cherry-picked from linux rc tree.
>
> V1-->V2
>   * Incorporated pavel's review comments.
>   https://lists.cip-project.org/pipermail/cip-dev/2019-November/003770.html
>

I checked this series, looks good to me with out patch 03.

Best regards,
  Nobuhiro



> Ai Kyuse (3):
>   mmc: tmio: enhance illegal sequence handling
>   mmc: tmio: Add hw reset support
>   mmc: tmio: Add tuning support
>
> Chris Brandt (2):
>   mmc: tmio-mmc: add support for 32bit data port
>   mmc: sh_mobile_sdhi: add ocr_mask option
>
> Masaharu Hayakawa (1):
>   mmc: tmio: always get number of taps
>
> Simon Horman (5):
>   mmc: tmio: document mandatory and optional callbacks
>   mmc: core: Add helper to see if a host can be retuned
>   mmc: sh_mobile_sdhi: Add tuning support
>   mmc: tmio: drop filenames from comment at top of source
>   mmc: renesas-sdhi, tmio: make dma more modular
>
> Ulf Hansson (1):
>   mmc: tmio: Remove redundant check of mmc->slot.cd_irq
>
> Wolfram Sang (19):
>   mmc: tmio: fix wrong bitmask for SDIO irqs
>   mmc: tmio: remove SDIO from TODO list
>   mmc: tmio: use SDIO master interrupt bit only when allowed
>   mmc: sh_mobile_sdhi: simplify accessing DT data
>   mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
>   mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
>   mmc: sh_mobile_sdhi: improve prerequisites for tuning
>   mmc: sh_mobile_sdhi: remove superfluous check in SCC error check
>   mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
>   mmc: sh_mobile_sdhi: enable HS200
>   mmc: host: tmio: drop superfluous exit path
>   mmc: host: tmio: disable clocks when unbinding
>   mmc: host: tmio: refactor calls to sdio irq
>   mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
>   mmc: tmio: discard obsolete SDIO irqs before enabling irqs
>   mmc: tmio: ensure end of DMA and SD access are in sync
>   mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
>   mmc: host: tmio: don't BUG on unsupported stop commands
>   mmc: host: tmio: fill in response from auto cmd12
>
>  drivers/mmc/host/Makefile         |   3 +-
>  drivers/mmc/host/sh_mobile_sdhi.c | 267 ++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc.c       |  10 +-
>  drivers/mmc/host/tmio_mmc.h       | 102 +++++++++------
>  drivers/mmc/host/tmio_mmc_dma.c   |  86 +++++++-----
>  drivers/mmc/host/tmio_mmc_pio.c   | 248 ++++++++++++++++++++++++++++-------
>  include/linux/mfd/tmio.h          |   7 +-
>  include/linux/mmc/host.h          |   5 +
>  8 files changed, 588 insertions(+), 140 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev



--
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
