Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DAC433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.2126.1648666499484324481
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211070"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:54:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D4D640D44CB;
	Thu, 31 Mar 2022 03:54:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/39] Add SD/eMMC support for Renesas RZ/G2L SoC
Date: Wed, 30 Mar 2022 19:54:15 +0100
Message-Id: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7851

Hi All,

This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
enables this interfaces on Renesas RZ/G2L SMARC EVK.

All the patches have been cherry picked from v5.17 release.

Cheers,
Prabhakar

Biju Das (9):
  mmc: tmio: reinit card irqs in reset routine
  clk: renesas: rzg2l: Add SDHI clk mux support
  clk: renesas: r9a07g044: Add SDHI clock and reset entries
  dt-bindings: mmc: renesas,sdhi: Fix dtbs-check warning
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L bindings
  dt-bindings: mmc: renesas,sdhi: Rename RZ/G2L clocks
  arm64: dts: renesas: r9a07g044: Add SDHI nodes
  arm64: dts: renesas: rzg2l-smarc-som: Enable eMMC on SMARC platform
  arm64: dts: renesas: rzg2l-smarc: Enable microSD on SMARC platform

Geert Uytterhoeven (1):
  clk: renesas: rzg2l: Add missing kerneldoc for resets

Lad Prabhakar (2):
  clk: renesas: rzg2l: Check return value of pm_genpd_init()
  clk: renesas: rzg2l: propagate return value
    of_genpd_add_provider_simple()

Masaharu Hayakawa (1):
  mmc: tmio: Add data timeout error detection

Rob Herring (2):
  dt-bindings: Fix errors in 'if' schemas
  dt-bindings: Drop redundant minItems/maxItems

Takeshi Saito (1):
  mmc: tmio: restore bus width when resetting

Wolfram Sang (21):
  mmc: renesas_sdhi: probe into TMIO after SCC parameters have been
    setup
  mmc: renesas_sdhi: populate SCC pointer at the proper place
  mmc: renesas_sdhi: simplify reset routine a little
  mmc: renesas_sdhi: clear TAPEN when resetting, too
  mmc: renesas_sdhi: merge the SCC reset functions
  mmc: renesas_sdhi: remove superfluous SCLKEN
  mmc: renesas_sdhi: improve HOST_MODE usage
  mmc: renesas_sdhi: don't hardcode SDIF values
  mmc: renesas_sdhi: sort includes
  mmc: tmio: set max_busy_timeout
  mmc: tmio: add hook for custom busy_wait calculation
  mmc: renesas_sdhi: populate hook for longer busy_wait
  mmc: tmio: support custom irq masks
  mmc: renesas_sdhi: use custom mask for TMIO_MASK_ALL
  mmc: tmio: abort DMA before reset
  mmc: renesas_sdhi: break SCC reset into own function
  mmc: renesas_sdhi: do hard reset if possible
  mmc: tmio: always flag retune when resetting and a card is present
  mmc: tmio: always restore irq register
  mmc: tmio: reenable card irqs after the reset callback
  dt-bindings: mmc: renesas,sdhi: Add optional SDnH clock

Yoshihiro Shimoda (2):
  mmc: renesas_internal_dmac: add pre_req and post_req support
  mmc: renesas_sdhi: Add a condition of cmd/data timeout for retune

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 153 ++++++++++++-----
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  32 ++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 143 ++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  62 +++++++
 drivers/clk/renesas/r9a07g044-cpg.c           |  36 ++++
 drivers/clk/renesas/rzg2l-cpg.c               | 136 ++++++++++++++-
 drivers/clk/renesas/rzg2l-cpg.h               |  19 +++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/renesas_sdhi.h               |   2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 155 ++++++++++++------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  91 +++++++++-
 drivers/mmc/host/tmio_mmc.h                   |  11 +-
 drivers/mmc/host/tmio_mmc_core.c              |  88 ++++++----
 drivers/mmc/host/uniphier-sd.c                |   1 +
 include/linux/mfd/tmio.h                      |   7 +-
 15 files changed, 794 insertions(+), 143 deletions(-)

-- 
2.17.1


