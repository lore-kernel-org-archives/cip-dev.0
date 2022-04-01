Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07226C64EC4
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.3593.1648842159735942678
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453796"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 95B2B4011436;
	Sat,  2 Apr 2022 04:42:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 00/40] Add SD/eMMC support for Renesas
 RZ/G2L SoC
Date: Fri,  1 Apr 2022 20:41:54 +0100
Message-Id: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7911

Hi All,

This patch series adds support for SD/eMMC on Renesas RZ/G2L SoC and
enables this interfaces on Renesas RZ/G2L SMARC EVK.

All the patches have been cherry picked from v5.17 release.

Resending as I had missed a patch (0001) earlier, reset of the patches
havent been changed. And also for some reason patches didnt make into
patchwork.

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

Wolfram Sang (22):
  mmc: renesas_sdhi: only reset SCC when its pointer is populated
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

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 153 ++++++++++++------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  32 ++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 143 ++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  62 +++++++
 drivers/clk/renesas/r9a07g044-cpg.c           |  36 +++++
 drivers/clk/renesas/rzg2l-cpg.c               | 136 +++++++++++++++-
 drivers/clk/renesas/rzg2l-cpg.h               |  19 +++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/renesas_sdhi.h               |   2 +
 drivers/mmc/host/renesas_sdhi_core.c          | 153 ++++++++++++------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  91 ++++++++++-
 drivers/mmc/host/tmio_mmc.h                   |  11 +-
 drivers/mmc/host/tmio_mmc_core.c              |  88 ++++++----
 drivers/mmc/host/uniphier-sd.c                |   1 +
 include/linux/mfd/tmio.h                      |   7 +-
 15 files changed, 794 insertions(+), 141 deletions(-)

-- 
2.17.1


