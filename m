Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4744FCEEB8
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:12:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43799.1772021557809195659
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:12:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Q+FZ9dEuR6mKTF+Q46Y04g==
X-CSE-MsgGUID: PcB/iq5lQSKbGD1VY+dBxQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:12:48 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2D871400D0F2;
	Wed, 25 Feb 2026 21:12:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 07/24] clk: renesas: rzv2h: Use GENMASK for PLL fields
Date: Wed, 25 Feb 2026 12:12:15 +0000
Message-ID: <20260225121232.129678-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21964

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a8943f7f0a736e211faa400fa9df1af8dd945347 upstream.

Replace the older FIELD_GET-wrapping helper macros with plain GENMASK
definitions for the PLL CLK1/CLK2 field masks (CPG_PLL_CLK1_KDIV,
CPG_PLL_CLK1_MDIV, CPG_PLL_CLK1_PDIV and CPG_PLL_CLK2_SDIV). Update
rzv2h_cpg_pll_clk_recalc_rate() to explicitly extract those fields with
FIELD_GET and cast the KDIV extraction to s16 to ensure proper sign
extension when computing the PLL output rate.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251015192611.241920-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index f468afbb54e2..125e7aa05ebd 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -49,11 +49,11 @@
 #define CPG_PLL_STBY_RESETB	BIT(0)
 #define CPG_PLL_STBY_RESETB_WEN	BIT(16)
 #define CPG_PLL_CLK1(x)		((x) + 0x004)
-#define CPG_PLL_CLK1_KDIV(x)	((s16)FIELD_GET(GENMASK(31, 16), (x)))
-#define CPG_PLL_CLK1_MDIV(x)	FIELD_GET(GENMASK(15, 6), (x))
-#define CPG_PLL_CLK1_PDIV(x)	FIELD_GET(GENMASK(5, 0), (x))
+#define CPG_PLL_CLK1_KDIV	GENMASK(31, 16)
+#define CPG_PLL_CLK1_MDIV	GENMASK(15, 6)
+#define CPG_PLL_CLK1_PDIV	GENMASK(5, 0)
 #define CPG_PLL_CLK2(x)		((x) + 0x008)
-#define CPG_PLL_CLK2_SDIV(x)	FIELD_GET(GENMASK(2, 0), (x))
+#define CPG_PLL_CLK2_SDIV	GENMASK(2, 0)
 #define CPG_PLL_MON(x)		((x) + 0x010)
 #define CPG_PLL_MON_RESETB	BIT(0)
 #define CPG_PLL_MON_LOCK	BIT(4)
@@ -231,10 +231,11 @@ static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	clk1 = readl(priv->base + CPG_PLL_CLK1(pll.offset));
 	clk2 = readl(priv->base + CPG_PLL_CLK2(pll.offset));
 
-	rate = mul_u64_u32_shr(parent_rate, (CPG_PLL_CLK1_MDIV(clk1) << 16) +
-			       CPG_PLL_CLK1_KDIV(clk1), 16 + CPG_PLL_CLK2_SDIV(clk2));
+	rate = mul_u64_u32_shr(parent_rate, (FIELD_GET(CPG_PLL_CLK1_MDIV, clk1) << 16) +
+			       (s16)FIELD_GET(CPG_PLL_CLK1_KDIV, clk1),
+			       16 + FIELD_GET(CPG_PLL_CLK2_SDIV, clk2));
 
-	return DIV_ROUND_CLOSEST_ULL(rate, CPG_PLL_CLK1_PDIV(clk1));
+	return DIV_ROUND_CLOSEST_ULL(rate, FIELD_GET(CPG_PLL_CLK1_PDIV, clk1));
 }
 
 static const struct clk_ops rzv2h_cpg_pll_ops = {
-- 
2.51.0


