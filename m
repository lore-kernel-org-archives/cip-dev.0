Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8DAEB64DD
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 15:32:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.10926.1689694348777557318
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 08:32:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169778328"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jul 2023 00:32:27 +0900
Received: from mulinux.home (unknown [10.226.93.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CCA2B400563A;
	Wed, 19 Jul 2023 00:32:24 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 4/6] mmc: renesas_sdhi: Add RZ/V2M compatible string
Date: Tue, 18 Jul 2023 16:32:10 +0100
Message-Id: <20230718153212.327448-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 15:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12407

Commit 08e03039e0000a7ec7ba13dc18bddc6afd32cb27 upstream.

The SDHI/eMMC IPs found with the RZ/V2M (a.k.a. r9a09g011), are
very similar to the ones found in R-Car Gen3, but they are not
exactly the same, and as a result need an SoC specific compatible
string for fine tuning driver support.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221213230129.549968-4-fabrizio.castro.jz@renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 7c81c2680701..3e254f76c1c6 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -211,6 +211,11 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
 	.manual_tap_correction = true,
 };
 
+static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
+	.fixed_addr_mode = true,
+	.hs400_disabled = true,
+};
+
 /*
  * Note for r8a7796 / r8a774a1: we can't distinguish ES1.1 and 1.2 as of now.
  * So, we want to treat them equally and only have a match for ES1.2 to enforce
@@ -252,6 +257,11 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.quirks = &sdhi_quirks_r8a77990,
 };
 
+static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compatible = {
+	.of_data = &of_data_rcar_gen3,
+	.quirks = &sdhi_quirks_r9a09g011,
+};
+
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
 	.of_data = &of_data_rcar_gen3,
 };
@@ -275,6 +285,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
+	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_r9a09g011_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
-- 
2.34.1


