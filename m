Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98BAC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74901.1752488224245328262
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: oHbXQxi2TzWKuPVha6/qCA==
X-CSE-MsgGUID: lTBPN7diSq6cA6Ou7a5Z4A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2BD6D400D4C7;
	Mon, 14 Jul 2025 19:17:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 05/36] clk: renesas: rzv2h: Rename PLL field macros for consistency
Date: Mon, 14 Jul 2025 11:16:05 +0100
Message-ID: <20250714101650.80381-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19491

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 360387a8f17d2cf7afd894c318df959112f377c7 upstream.

Rename PLL field extraction macros to include the associated register name
(`CPG_PLL_CLK1` or `CPG_PLL_CLK2`) to maintain consistency with other PLL
register macros. Update all corresponding macro references accordingly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index fd9d401d184fe..b8bed0c1d9186 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -48,11 +48,11 @@
 #define CPG_PLL_STBY_RESETB	BIT(0)
 #define CPG_PLL_STBY_RESETB_WEN	BIT(16)
 #define CPG_PLL_CLK1(x)		((x) + 0x004)
-#define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
-#define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
-#define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
+#define CPG_PLL_CLK1_KDIV(x)	((s16)FIELD_GET(GENMASK(31, 16), (x)))
+#define CPG_PLL_CLK1_MDIV(x)	FIELD_GET(GENMASK(15, 6), (x))
+#define CPG_PLL_CLK1_PDIV(x)	FIELD_GET(GENMASK(5, 0), (x))
 #define CPG_PLL_CLK2(x)		((x) + 0x008)
-#define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
+#define CPG_PLL_CLK2_SDIV(x)	FIELD_GET(GENMASK(2, 0), (x))
 #define CPG_PLL_MON(x)		((x) + 0x010)
 #define CPG_PLL_MON_RESETB	BIT(0)
 #define CPG_PLL_MON_LOCK	BIT(4)
@@ -210,10 +210,10 @@ static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	clk1 = readl(priv->base + CPG_PLL_CLK1(pll.offset));
 	clk2 = readl(priv->base + CPG_PLL_CLK2(pll.offset));
 
-	rate = mul_u64_u32_shr(parent_rate, (MDIV(clk1) << 16) + KDIV(clk1),
-			       16 + SDIV(clk2));
+	rate = mul_u64_u32_shr(parent_rate, (CPG_PLL_CLK1_MDIV(clk1) << 16) +
+			       CPG_PLL_CLK1_KDIV(clk1), 16 + CPG_PLL_CLK2_SDIV(clk2));
 
-	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(clk1));
+	return DIV_ROUND_CLOSEST_ULL(rate, CPG_PLL_CLK1_PDIV(clk1));
 }
 
 static const struct clk_ops rzv2h_cpg_pll_ops = {
-- 
2.43.0


