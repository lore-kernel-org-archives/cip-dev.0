Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6CC83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74901.1752488224245328262
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: J/pZ3csSSPWpF6UVADUBVQ==
X-CSE-MsgGUID: fhl0mjYeT5movdxm+KiVWw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 990E5400CEEA;
	Mon, 14 Jul 2025 19:17:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 10/36] clk: renesas: rzv2h: Add support for static mux clocks
Date: Mon, 14 Jul 2025 11:16:10 +0100
Message-ID: <20250714101650.80381-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19496

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c1d6f686e5cb2530e1d04a4c994c3085c00e644c upstream.

Add support for `CLK_TYPE_SMUX` to register static muxed clocks on the
Renesas RZ/V2H(P) SoC.  Extend `cpg_core_clk` to include parent names,
mux flags, and a new `smuxed` struct.  Update clock registration to
handle static mux clocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 21 +++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 83175c3269647..7b797668b65c9 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -393,6 +393,24 @@ rzv2h_cpg_ddiv_clk_register(const struct cpg_core_clk *core,
 	return div->hw.clk;
 }
 
+static struct clk * __init
+rzv2h_cpg_mux_clk_register(const struct cpg_core_clk *core,
+			   struct rzv2h_cpg_priv *priv)
+{
+	struct smuxed mux = core->cfg.smux;
+	const struct clk_hw *clk_hw;
+
+	clk_hw = devm_clk_hw_register_mux(priv->dev, core->name,
+					  core->parent_names, core->num_parents,
+					  core->flag, priv->base + mux.offset,
+					  mux.shift, mux.width,
+					  core->mux_flags, &priv->rmw_lock);
+	if (IS_ERR(clk_hw))
+		return ERR_CAST(clk_hw);
+
+	return clk_hw->clk;
+}
+
 static struct clk
 *rzv2h_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
 			       void *data)
@@ -477,6 +495,9 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk *core,
 	case CLK_TYPE_DDIV:
 		clk = rzv2h_cpg_ddiv_clk_register(core, priv);
 		break;
+	case CLK_TYPE_SMUX:
+		clk = rzv2h_cpg_mux_clk_register(core, priv);
+		break;
 	default:
 		goto fail;
 	}
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 59f72fbed1337..03e602d70f692 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -53,6 +53,26 @@ struct ddiv {
 		.monbit = _monbit \
 	})
 
+/**
+ * struct smuxed - Structure for static muxed clocks
+ *
+ * @offset: register offset
+ * @shift: position of the divider field
+ * @width: width of the divider field
+ */
+struct smuxed {
+	unsigned int offset:11;
+	unsigned int shift:4;
+	unsigned int width:4;
+};
+
+#define SMUX_PACK(_offset, _shift, _width) \
+	((struct smuxed){ \
+		.offset = (_offset), \
+		.shift = (_shift), \
+		.width = (_width), \
+	})
+
 #define CPG_CDDIV0		(0x400)
 #define CPG_CDDIV1		(0x404)
 #define CPG_CDDIV3		(0x40C)
@@ -96,8 +116,12 @@ struct cpg_core_clk {
 		unsigned int conf;
 		struct ddiv ddiv;
 		struct pll pll;
+		struct smuxed smux;
 	} cfg;
 	const struct clk_div_table *dtable;
+	const char * const *parent_names;
+	unsigned int num_parents;
+	u8 mux_flags;
 	u32 flag;
 };
 
@@ -107,6 +131,7 @@ enum clk_types {
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
 	CLK_TYPE_PLL,
 	CLK_TYPE_DDIV,		/* Dynamic Switching Divider */
+	CLK_TYPE_SMUX,		/* Static Mux */
 };
 
 #define DEF_TYPE(_name, _id, _type...) \
@@ -125,6 +150,13 @@ enum clk_types {
 		.parent = _parent, \
 		.dtable = _dtable, \
 		.flag = CLK_DIVIDER_HIWORD_MASK)
+#define DEF_SMUX(_name, _id, _smux_packed, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SMUX, \
+		 .cfg.smux = _smux_packed, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .flag = CLK_SET_RATE_PARENT, \
+		 .mux_flags = CLK_MUX_HIWORD_MASK)
 
 /**
  * struct rzv2h_mod_clk - Module Clocks definitions
-- 
2.43.0


