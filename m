Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E2EC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74901.1752488224245328262
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: nYFsgV17QlO07zFspBrkxw==
X-CSE-MsgGUID: 5R4WtZTZRZ2VW7gksL+0Zg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AE0BA400D4C7;
	Mon, 14 Jul 2025 19:17:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 11/36] clk: renesas: rzv2h: Add macro for defining static dividers
Date: Mon, 14 Jul 2025 11:16:11 +0100
Message-ID: <20250714101650.80381-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19497

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6e1c795071359dc36e26ed96a271e06687d84f74 upstream.

Unlike dynamic dividers, static dividers do not have a monitor bit.
Introduce the `DEF_CSDIV()` macro for defining static dividers, ensuring
consistency with existing dynamic divider macros.

Additionally, introduce the `CSDIV_NO_MON` macro to indicate the absence
of a monitor bit, allowing the monitoring step to be skipped when `mon`
is set to `CSDIV_NO_MON`.

Note, `rzv2h_cpg_ddiv_clk_register()` will be re-used instead of generic
`clk_hw_register_divider_table()` for registering satic dividers as some
of the static dividers require RMW operations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c |  3 +++
 drivers/clk/renesas/rzv2h-cpg.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 7b797668b65c9..e3867ba7cc95a 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -298,6 +298,9 @@ static inline int rzv2h_cpg_wait_ddiv_clk_update_done(void __iomem *base, u8 mon
 	u32 bitmask = BIT(mon);
 	u32 val;
 
+	if (mon == CSDIV_NO_MON)
+		return 0;
+
 	return readl_poll_timeout_atomic(base + CPG_CLKSTATUS0, val, !(val & bitmask), 10, 200);
 }
 
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 03e602d70f692..00b52b459aadc 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -45,6 +45,14 @@ struct ddiv {
 	unsigned int monbit:5;
 };
 
+/*
+ * On RZ/V2H(P), the dynamic divider clock supports up to 19 monitor bits,
+ * while on RZ/G3E, it supports up to 16 monitor bits. Use the maximum value
+ * `0x1f` to indicate that monitor bits are not supported for static divider
+ * clocks.
+ */
+#define CSDIV_NO_MON	(0x1f)
+
 #define DDIV_PACK(_offset, _shift, _width, _monbit) \
 	((struct ddiv){ \
 		.offset = _offset, \
@@ -150,6 +158,8 @@ enum clk_types {
 		.parent = _parent, \
 		.dtable = _dtable, \
 		.flag = CLK_DIVIDER_HIWORD_MASK)
+#define DEF_CSDIV(_name, _id, _parent, _ddiv_packed, _dtable) \
+	DEF_DDIV(_name, _id, _parent, _ddiv_packed, _dtable)
 #define DEF_SMUX(_name, _id, _smux_packed, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SMUX, \
 		 .cfg.smux = _smux_packed, \
-- 
2.43.0


