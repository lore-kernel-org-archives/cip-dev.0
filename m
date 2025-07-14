Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BBC83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.75000.1752488238953470095
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: hTwm+6IJQ+Gzm8p4/jNv/g==
X-CSE-MsgGUID: fvDwevbqQ8a+JwqAqRnUHQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D2AD4400CEEA;
	Mon, 14 Jul 2025 19:17:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/36] clk: renesas: rzv2h: Support static dividers without RMW
Date: Mon, 14 Jul 2025 11:16:12 +0100
Message-ID: <20250714101650.80381-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19498

commit 52239ebe624016d01b3bf8a3a8510dfd57f56b21 upstream.

Add support for static dividers that do not require read-modify-write
(RMW) operations.  This enables the use of the generic clk_divider_ops
instead of the custom RMW-based implementation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c |  5 ++++-
 drivers/clk/renesas/rzv2h-cpg.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index e3867ba7cc95a..4a003a1ed8ec7 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -374,7 +374,10 @@ rzv2h_cpg_ddiv_clk_register(const struct cpg_core_clk *core,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = core->name;
-	init.ops = &rzv2h_ddiv_clk_divider_ops;
+	if (cfg_ddiv.no_rmw)
+		init.ops = &clk_divider_ops;
+	else
+		init.ops = &rzv2h_ddiv_clk_divider_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 00b52b459aadc..97054f2071131 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -37,12 +37,15 @@ struct pll {
  * @shift: position of the divider bit
  * @width: width of the divider
  * @monbit: monitor bit in CPG_CLKSTATUS0 register
+ * @no_rmw: flag to indicate if the register is read-modify-write
+ *        (1: no RMW, 0: RMW)
  */
 struct ddiv {
 	unsigned int offset:11;
 	unsigned int shift:4;
 	unsigned int width:4;
 	unsigned int monbit:5;
+	unsigned int no_rmw:1;
 };
 
 /*
@@ -61,6 +64,15 @@ struct ddiv {
 		.monbit = _monbit \
 	})
 
+#define DDIV_PACK_NO_RMW(_offset, _shift, _width, _monbit) \
+	((struct ddiv){ \
+		.offset = (_offset), \
+		.shift = (_shift), \
+		.width = (_width), \
+		.monbit = (_monbit), \
+		.no_rmw = 1 \
+	})
+
 /**
  * struct smuxed - Structure for static muxed clocks
  *
-- 
2.43.0


