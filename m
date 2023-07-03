Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49934C3063F
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:03 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.39279.1688404616547405615
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="166630704"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2023 02:17:00 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 633E64003863;
	Tue,  4 Jul 2023 02:16:58 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 3/5] mmc: renesas_sdhi: Add RZ/V2M compatible string
Date: Mon,  3 Jul 2023 18:16:47 +0100
Message-Id: <20230703171649.15862-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12193

Commit 08e03039e0000a7ec7ba13dc18bddc6afd32cb27 upstream.

The SDHI/eMMC IPs found with the RZ/V2M (a.k.a. r9a09g011), are
very similar to the ones found in R-Car Gen3, but they are not
exactly the same, and as a result need an SoC specific compatible
string for fine tuning driver support.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221213230129.549968-4-fabrizio.castro.jz@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Fabrizio: Adapted data structures to what's available in v5.10.y-cip ]
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c          | 1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index b96f16ed6fd5..ab6c3d6fcc63 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -964,6 +964,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a77965", .data = &sdhi_quirks_r8a77965 },
 	{ .soc_id = "r8a77980", .data = &sdhi_quirks_nohs400 },
 	{ .soc_id = "r8a77990", .data = &sdhi_quirks_r8a77990 },
+	{ .soc_id = "r9a09g011", .data = &sdhi_quirks_nohs400 },
 	{ /* Sentinel. */ },
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index bc6040be657b..c6ddfe8215c7 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -127,6 +127,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
 };
@@ -400,6 +401,8 @@ static const struct soc_device_attribute soc_dma_quirks[] = {
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
 	{ .soc_id = "r8a7796", .revision = "ES1.0",
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
+	{ .soc_id = "r9a09g011",
+	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1


