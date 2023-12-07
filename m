Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E5C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.81315.1701946517933410769
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185659857"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:38 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6DD07420DBD6;
	Thu,  7 Dec 2023 19:55:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/12] clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
Date: Thu,  7 Dec 2023 10:55:08 +0000
Message-Id: <20231207105508.171162-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13824

commit d1c20885d3b01e6a62e920af4b227abd294d22f3 upstream.

As per the RZ/G2L HW(Rev.1.30 May2023) manual, there are no "write enable"
bits in the CPG_SIPLL5_CLK1 register.  So fix the CPG_SIPLL5_CLK register
write by removing the "write enable" bits.

Fixes: 1561380ee72f ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230518152334.514922-1-biju.das.jz@bp.renesas.com
[geert: Remove CPG_SIPLL5_CLK1_*_WEN bit definitions]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 6 ++----
 drivers/clk/renesas/rzg2l-cpg.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 5dfe3624f681..77513ceaaf2d 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -600,10 +600,8 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	}
 
 	/* Output clock setting 1 */
-	writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_POSTDIV2_WEN |
-	       CPG_SIPLL5_CLK1_REFDIV_WEN  | (params.pl5_postdiv1 << 0) |
-	       (params.pl5_postdiv2 << 4) | (params.pl5_refdiv << 8),
-	       priv->base + CPG_SIPLL5_CLK1);
+	writel((params.pl5_postdiv1 << 0) | (params.pl5_postdiv2 << 4) |
+	       (params.pl5_refdiv << 8), priv->base + CPG_SIPLL5_CLK1);
 
 	/* Output clock setting, SSCG modulation value setting 3 */
 	writel((params.pl5_fracin << 8), priv->base + CPG_SIPLL5_CLK3);
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index cecbdf5e4f93..b33a3e79161b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -32,9 +32,6 @@
 #define CPG_SIPLL5_STBY_RESETB_WEN	BIT(16)
 #define CPG_SIPLL5_STBY_SSCG_EN_WEN	BIT(18)
 #define CPG_SIPLL5_STBY_DOWNSPREAD_WEN	BIT(20)
-#define CPG_SIPLL5_CLK1_POSTDIV1_WEN	BIT(16)
-#define CPG_SIPLL5_CLK1_POSTDIV2_WEN	BIT(20)
-#define CPG_SIPLL5_CLK1_REFDIV_WEN	BIT(24)
 #define CPG_SIPLL5_CLK4_RESV_LSB	(0xFF)
 #define CPG_SIPLL5_MON_PLL5_LOCK	BIT(4)
 
-- 
2.25.1


