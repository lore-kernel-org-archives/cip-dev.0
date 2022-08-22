Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1870C32772
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 11:20:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.16852.1661167253316704341
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Aug 2022 04:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,254,1654527600";
   d="scan'208";a="132128099"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Aug 2022 20:20:51 +0900
Received: from localhost.localdomain (unknown [10.226.93.23])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5A03E4005621;
	Mon, 22 Aug 2022 20:20:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix reset status function
Date: Mon, 22 Aug 2022 12:20:46 +0100
Message-Id: <20220822112046.1067688-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Aug 2022 11:20:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9294

commit 02c96ed9e4cd1f47bfcd10296fec6b0b69d6b3c6 upstream.

As per RZ/G2L HW(Rev.1.10) manual, reset monitor register value 0 means
reset signal is not applied (deassert state) and 1 means reset signal
is applied (assert state).

reset_control_status() expects a positive value if the reset line is
asserted. But rzg2l_cpg_status function returns zero for asserted
state.

This patch fixes the issue by adding double inverted logic, so that
reset_control_status returns a positive value if the reset line is
asserted.

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220531071657.104121-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Manually applied the changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index f626d2704477..a03bc9cbbd4b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -742,7 +742,7 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 	unsigned int reg = info->resets[id].off;
 	u32 bitmask = BIT(info->resets[id].bit);
 
-	return !(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
+	return !!(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
 }
 
 static const struct reset_control_ops rzg2l_cpg_reset_ops = {
-- 
2.25.1


