Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE089C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722263"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 90D3640121CF;
	Thu, 16 Dec 2021 21:55:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/24] clk: renesas: rzg2l: Fix clk status function
Date: Thu, 16 Dec 2021 12:54:46 +0000
Message-Id: <20211216125446.15451-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7147

From: Biju Das <biju.das.jz@bp.renesas.com>

commit fa2a30f8e0aa9304919750b116a9e9e322465299 upstream.

As per RZ/G2L HW(Rev.0.50) manual, clock monitor register value
0 means clock is not supplied and 1 means clock is supplied.
This patch fixes the issue by removing the inverted logic.

Fixing the above, triggered following 2 issues

1) GIC interrupts don't work if we disable IA55_CLK and DMAC_ACLK.
   Fixed this issue by adding these clocks as critical clocks.

2) DMA is not working, since the DMA driver is not turning on DMAC_PCLK.
   So will provide a fix in the DMA driver to turn on DMA_PCLK.

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922112405.26413-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 834a7a73de33..1501547a11a3 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -451,7 +451,7 @@ static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 
 	value = readl(priv->base + CLK_MON_R(clock->off));
 
-	return !(value & bitmask);
+	return value & bitmask;
 }
 
 static const struct clk_ops rzg2l_mod_clock_ops = {
-- 
2.17.1


