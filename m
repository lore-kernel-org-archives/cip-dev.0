Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E1C55189
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:13 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2476.1785575706274794926
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ql2DQwqz;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so3750925e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575704; x=1786180504; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJ7pZtoQ/dxJz9BRTCy3bDrp01S9AM/U+uRPJamvBFE=;
        b=ql2DQwqzeaWdcbU16MivlVUMEbdSgWStnO72tJhvmgAigImJgMVby7znHebzApNy69
         RbjRDfqk+pUp1gbP2vzx6E9wf9c33ratdsDk2wZJ/zz8y6qBCcy2mMQPGI2VDJOchguZ
         Gm4DxGhdB1/1HJAWIG46mSuhxLUIr3yJhcLdwJH35hvsjObS7hb+CyPhuTTWfYADf9es
         kXoKQEPJz8du5/OxNbpHQetFfrH/IqIzg+IUMu+dITEnRUzWu18QdJpvo7atky/mBtQc
         Upyede/afeWGYT+DCFbkCV1fdsj1U0Y/21k7hI3j2D0Vb/uw4HhjUq1bVA1CSV6yb4Ps
         XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575704; x=1786180504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJ7pZtoQ/dxJz9BRTCy3bDrp01S9AM/U+uRPJamvBFE=;
        b=ShgNrruHtPPfGmi5yECMQZu0g/fG/nZrHnUmT1g6dA5SXZN+f0Qo0Em0my+bdt3uyJ
         GchGEKYAFKRYEqHbV0efciiGnyPRfHgTe62FNK8qh+l/2W5SXneZdrlMvpwZ2TkT6F+j
         NHBo82EW4Fx9HT4RzlQ6vViZ4o7OaMC3W8MbGsLhhWIoRpZEjgFjgAxCCJuJOVznz5O2
         5MzgawUaOLWKX4M1UNjhNt/2LWA06sbusYwtL5nG6ONGMSShuUUyc0idwwOGKaza4EFh
         P8dY01UAsvF480irkzzuZY0QJiph8di+T0q7AvAivljd95Xdz0twtBPXlGkanHltfJIS
         IV4w==
X-Gm-Message-State: AOJu0YyD35hxoFhSkhuAU+2XPdA7Freyt84PgPCk/KjU4rzVcvpQZz7V
	xpU91L7qxVwlnzZQPImfoMCzsehfy5CUFNAqRTLCFYumFEwut94QjWvi8nLK3Q==
X-Gm-Gg: AR+sD10EMYnWyIsINIXedRgCj0zchn7MvqRjcYzZPLNbsqPO4eAA9XADBkW0qDnbxYQ
	145/H/culesm0LbLmQXNxs192qbmNWhnb0+zeb+MqiGE/AcTbVn0QVkBinv7tkuzTL1FWeN0EVM
	CJ/9t2P+0xgPMrSomNi3Wd1GBpbbdgsXQuXIQghaLWz6p6/1+DZyzLT7Cqvv3GXAmIIt1YFSbLm
	fGOWWJ3gr/Q3eCqWk0EMdRq/UFnFZXSauOxAA0ygfip4n2UHSv/Nz7dnD8Qs2ipk1c1nOWVVjui
	IuYgL+Pe74e4eRl2hd9Ccor1yR1ZoVJuVaQV6kFO4Gg5es/4hifuRQgzK90pKz10Xel+t/5VZpb
	TVUbqRqJ8rzyJFUI6QKgQYDZ9U8iMQJj3JUHWaBLXPXL0NjHUxmMCkQyvHDMty1ChUjPyYy4Z9E
	x70W6ZES5yac8ZoaUwk+pLJKPO9FaAA7+T9OsZl91Q5vWSvlW1cBZGrx/Z48rXXc+3R1Pel9bhY
	iUqHV9bZ8GfTw==
X-Received: by 2002:a05:600c:46c3:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4980eb8d081mr24378445e9.1.1785575704278;
        Sat, 01 Aug 2026 02:15:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/19] clk: renesas: rzg3s/rzg3l: Simplify PLL configuration macro
Date: Sat,  1 Aug 2026 10:14:37 +0100
Message-ID: <20260801091458.14026-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23833

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2e3974747e83de21559d1f937746414e7f881253 ]

Replace the per-SoC G3S_PLL146_CONF() and G3L_PLL1467_CONF() macros with
a unified CPG_PLL_CONF(stby, setting) macro defined in rzg2l-cpg.h.

Drop the now-redundant GET_REG_SAMPLL_{CLK1, SETTING}() macros, replacing
the latter with CPG_PLL1_SETTING_OFFSET() using FIELD_GET() to extract the
offset value. Update RZG3L_PLL_{STBY,MON}_OFFSET() macros to derive
offsets directly from CPG_PLL_STBY_OFFSET().

No functional changes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260519141518.389670-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c |  5 +----
 drivers/clk/renesas/r9a08g046-cpg.c |  7 ++-----
 drivers/clk/renesas/rzg2l-cpg.c     | 11 +++++------
 drivers/clk/renesas/rzg2l-cpg.h     |  1 +
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 937a044cd5d3..2b71a2ff6292 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -49,9 +49,6 @@
 #define G3S_SEL_SDHI1		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 4, 2)
 #define G3S_SEL_SDHI2		SEL_PLL_PACK(G3S_CPG_SDHI_DSEL, 8, 2)
 
-/* PLL 1/4/6 configuration registers macro. */
-#define G3S_PLL146_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
-
 #define DEF_G3S_MUX(_name, _id, _conf, _parent_names, _mux_flags, _clk_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = (_conf), \
 		 .parent_names = (_parent_names), \
@@ -133,7 +130,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 
 	/* Internal Core Clocks */
 	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
-	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3S_PLL146_CONF(0x4, 0x8, 0x100),
+	DEF_G3S_PLL(".pll1", CLK_PLL1, CLK_EXTAL, CPG_PLL_CONF(0, 0x100),
 		    1100000000UL),
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index fc9db5a2f0ac..a57638734ce7 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -81,9 +81,6 @@
 #define G3L_SEL_RSPI1		SEL_PLL_PACK(G3L_CPG_RSPI_SSEL, 2, 2)
 #define G3L_SEL_RSPI2		SEL_PLL_PACK(G3L_CPG_RSPI_SSEL, 4, 2)
 
-/* PLL 1/4/6/7 configuration registers macro. */
-#define G3L_PLL1467_CONF(clk1, clk2, setting)	((clk1) << 22 | (clk2) << 12 | (setting))
-
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
 	LAST_DT_CORE_CLK = R9A08G046_USB_SCLK,
@@ -207,11 +204,11 @@ static const struct cpg_core_clk r9a08g046_core_clks[] __initconst = {
 	DEF_INPUT("eth1_rxc_rx_clk", CLK_ETH1_RXC_RX_CLK_IN),
 
 	/* Internal Core Clocks */
-	DEF_G3L_PLL(".pll1", CLK_PLL1, CLK_EXTAL, G3L_PLL1467_CONF(0x4, 0x8, 0x100),
+	DEF_G3L_PLL(".pll1", CLK_PLL1, CLK_EXTAL, CPG_PLL_CONF(0, 0x100),
 		    1200000000UL),
 	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
-	DEF_G3L_PLL(".pll6", CLK_PLL6, CLK_EXTAL, G3L_PLL1467_CONF(0x54, 0x58, 0),
+	DEF_G3L_PLL(".pll6", CLK_PLL6, CLK_EXTAL, CPG_PLL_CONF(0x50, 0),
 		    500000000UL),
 	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
 	DEF_FIXED(".pll2_div2_4", CLK_PLL2_DIV2_4, CLK_PLL2_DIV2, 1, 4),
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index dadd8653c854..bb63404922e5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -58,14 +58,15 @@
 #define RZG3S_DIV_NF		GENMASK(12, 1)
 #define RZG3S_SEL_PLL		BIT(0)
 
+#define CPG_PLL1_SETTING_OFFSET(conf)	FIELD_GET(GENMASK(11, 0), (conf))
 #define CPG_PLL_STBY_OFFSET(conf)	FIELD_GET(GENMASK(23, 12), (conf))
 #define CPG_PLL_CLK1_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0x4)
 #define CPG_PLL_CLK2_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0x8)
 
-#define RZG3L_PLL_STBY_OFFSET(x)	(GET_REG_SAMPLL_CLK1(x) - 0x4)
+#define RZG3L_PLL_STBY_OFFSET(x)	(CPG_PLL_STBY_OFFSET(x))
 #define RZG3L_PLL_STBY_RESETB		BIT(0)
 #define RZG3L_PLL_STBY_RESETB_WEN	BIT(16)
-#define RZG3L_PLL_MON_OFFSET(x)		(GET_REG_SAMPLL_CLK1(x) + 0x8)
+#define RZG3L_PLL_MON_OFFSET(x)		(CPG_PLL_STBY_OFFSET(x) + 0xc)
 #define RZG3L_PLL_MON_RESETB		BIT(0)
 #define RZG3L_PLL_MON_LOCK		BIT(4)
 
@@ -75,8 +76,6 @@
 #define CLK_MRST_R(reg)		(0x180 + (reg))
 
 #define GET_REG_OFFSET(val)		((val >> 20) & 0xfff)
-#define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
-#define GET_REG_SAMPLL_SETTING(val)	((val) & 0xfff)
 
 #define CPG_WEN_BIT		BIT(16)
 
@@ -1118,14 +1117,14 @@ static unsigned long rzg3s_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	u32 nir, nfr, mr, pr, val, setting;
 	u64 rate;
 
-	setting = GET_REG_SAMPLL_SETTING(pll_clk->conf);
+	setting = CPG_PLL1_SETTING_OFFSET(pll_clk->conf);
 	if (setting) {
 		val = readl(priv->base + setting);
 		if (val & RZG3S_SEL_PLL)
 			return pll_clk->default_rate;
 	}
 
-	val = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
+	val = readl(priv->base + CPG_PLL_CLK1_OFFSET(pll_clk->conf));
 
 	pr = 1 << FIELD_GET(RZG3S_DIV_P, val);
 	/* Hardware interprets values higher than 8 as p = 16. */
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 17ec6f285c21..bd6169f62538 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -59,6 +59,7 @@
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
 #define CPG_SAM_PLL_CONF(stby)		((stby) << 12)
+#define CPG_PLL_CONF(stby, setting)	((stby) << 12 | (setting))
 
 #define DDIV_PACK(offset, bitpos, size) \
 		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
-- 
2.43.0


