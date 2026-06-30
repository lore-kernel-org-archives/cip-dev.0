Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CEC44502
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19424.1782820128193930012
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PnTgcqAo;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47640541585so122940f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820126; x=1783424926; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uw6xrZ9x0Irx5MHh9Ql6EW6GRexvK4DCsNxBxgCX3A=;
        b=PnTgcqAoZaoKQQK4hY3rQLsY/iSzZOaaFYMOCgw89BBpAUBlDS4PagNyJuCRdLhzUz
         88khgtdPDa4iPEMkLLcvp4Cxip9yV+IAxikdMQJIPW0tJvoCU9kcp7BUEKVwwBG28vcW
         tqLd27m7BMV5WD9aw6lbBS2IQPO8Dbyw2XWiv1ThoR+95pt6038oA6i272pfhNSjefZK
         jXysm2rRXdRRiJxX77IoOOq9AXBYvDD4F5HR3thiEfDvgI5v0yZnVazAZSr2V+scv/66
         5N/BjkkMEBJLq+5RMnES8vrBTpBwqHSuI2llCglEtmrPzGRjHBg3EfXbw4410nUVHF98
         9mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820126; x=1783424926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uw6xrZ9x0Irx5MHh9Ql6EW6GRexvK4DCsNxBxgCX3A=;
        b=H8sLCIbYR8YCUx16JOhRCsHFOSjzhy0/Gx0t5brq8lomlvUDLuXpR+T4QhtABuV8xW
         Z/eGj7zYsqqb1E2kD2z7dA5tEXaDfw1/1PjTqiqnqLS2XZK3gHDObx9D9yLOkM584w29
         QoqXmANfgQQiCqTzvHNcgDPmLTacHyE5UxwXmQyD6jb3jwHr6OFUouQOGhu4tnXwAiL9
         QXRUQOZnN2sg++Zh1LxsomO6TeuXgP45FqbfB9v7tIobaqkQ8mKewg/pfZFcsBLrWHfz
         HxYYKyKO/RsRDO2Y/0JZ1v1aRwS0rAcFOQGYpd50yoBtBp3/9Q9LL1Cde1PlMYl/KQf+
         Hr1w==
X-Gm-Message-State: AOJu0Ywm/Yyulgwt4gcAGoUIGEy9sBKct66JTXO92o6bUHfmVLaIOJQ5
	jhQ4q9XD6LPWuOc5o3LPYs7Xx6qSea3A05b4SutxKQJFKKWNYUfue8ASPa+Xy6qy
X-Gm-Gg: AfdE7cmkni/6wmZ3zc0IpMFM34eQqbKmrfugmO2jZmqfLGY7CNUW5AMIP80XeScjM/k
	ym28IfyNw+GL4zHBVtI2GfKiDYWXKXLTEi8sFjTn1Fdu4hMlhNmWYM/FSzey3jmjf/YUF9eAVRn
	U0WxCDY2sKk6v+386bT6Wjl9z9/dklDeUx/WD3XFjSpsPuDgjV5/18+CZVw5B/2TUpXOn99OgCg
	fFXvfzplnjEysDSbaFvWMfcCKSqexpjE48JTfJGteD52hX8/YjTdgqSSKUFcj2sgLKEB38MAVfk
	gGuY3g/3N8T3uTWT4MgyR7o4D3gh+TgC2S49Fk3U0uS0JyBhh8u5Qujay1/uqlMLcZzKOjsUaJW
	lXsiQQK398TwVdrsCAC9IyCQeFMyT9d+99HjKYXTdwY/j6mdC397Ewf1XgPRYBMU3Zt2LZtHZ/f
	3+PcCDx0fOHg0FoyXuHo2AW9IIixx81xcvlaHtEA==
X-Received: by 2002:adf:e74c:0:b0:463:2220:4ff0 with SMTP id ffacd0b85a97d-4765907533amr187669f8f.27.1782820126309;
        Tue, 30 Jun 2026 04:48:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:46 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/39] clk: renesas: rzg2l: Rename mstp_clock to mod_clock
Date: Tue, 30 Jun 2026 12:47:30 +0100
Message-ID: <20260630114813.92739-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23335

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit b263e653c3722349a6efbb42d9e683d8ed1c24bf ]

The mstp_clock structure really represents a module clock (cfr. the
various rzg2l_mod_clock_*() functions and the to_mod_clock() helper),
and is not directly related to the "Module stop state".
Rename it to "mod_clock", and replace "mstp_clock" by "mod_clock".
to avoid confusion with the mstop registers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/53b3a730a784650762cdb27fdbde7a45b0c20db8.1749119264.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 44 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 0852fb27e039..c26b0a85df43 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1314,7 +1314,7 @@ struct mstop {
 };
 
 /**
- * struct mstp_clock - MSTP gating clock
+ * struct mod_clock - Module clock
  *
  * @hw: handle between common and hardware-specific interfaces
  * @priv: CPG/MSTP private data
@@ -1326,19 +1326,19 @@ struct mstop {
  * @num_shared_mstop_clks: number of the clocks sharing MSTOP with this clock
  * @enabled: soft state of the clock, if it is coupled with another clock
  */
-struct mstp_clock {
+struct mod_clock {
 	struct clk_hw hw;
 	struct rzg2l_cpg_priv *priv;
-	struct mstp_clock *sibling;
+	struct mod_clock *sibling;
 	struct mstop *mstop;
-	struct mstp_clock **shared_mstop_clks;
+	struct mod_clock **shared_mstop_clks;
 	u16 off;
 	u8 bit;
 	u8 num_shared_mstop_clks;
 	bool enabled;
 };
 
-#define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
+#define to_mod_clock(_hw) container_of(_hw, struct mod_clock, hw)
 
 #define for_each_mod_clock(mod_clock, hw, priv) \
 	for (unsigned int i = 0; (priv) && i < (priv)->num_mod_clks; i++) \
@@ -1348,7 +1348,7 @@ struct mstp_clock {
 			 ((mod_clock) = to_mod_clock(hw)))
 
 /* Need to be called with a lock held to avoid concurrent access to mstop->usecnt. */
-static void rzg2l_mod_clock_module_set_state(struct mstp_clock *clock,
+static void rzg2l_mod_clock_module_set_state(struct mod_clock *clock,
 					     bool standby)
 {
 	struct rzg2l_cpg_priv *priv = clock->priv;
@@ -1365,7 +1365,7 @@ static void rzg2l_mod_clock_module_set_state(struct mstp_clock *clock,
 		unsigned int criticals = 0;
 
 		for (unsigned int i = 0; i < clock->num_shared_mstop_clks; i++) {
-			struct mstp_clock *clk = clock->shared_mstop_clks[i];
+			struct mod_clock *clk = clock->shared_mstop_clks[i];
 
 			if (clk_hw_get_flags(&clk->hw) & CLK_IS_CRITICAL)
 				criticals++;
@@ -1407,7 +1407,7 @@ static void rzg2l_mod_clock_module_set_state(struct mstp_clock *clock,
 static int rzg2l_mod_clock_mstop_show(struct seq_file *s, void *what)
 {
 	struct rzg2l_cpg_priv *priv = s->private;
-	struct mstp_clock *clk;
+	struct mod_clock *clk;
 	struct clk_hw *hw;
 
 	seq_printf(s, "%-20s %-5s %-10s\n", "", "", "MSTOP");
@@ -1442,7 +1442,7 @@ DEFINE_SHOW_ATTRIBUTE(rzg2l_mod_clock_mstop);
 
 static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
-	struct mstp_clock *clock = to_mod_clock(hw);
+	struct mod_clock *clock = to_mod_clock(hw);
 	struct rzg2l_cpg_priv *priv = clock->priv;
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
@@ -1489,7 +1489,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 static int rzg2l_mod_clock_enable(struct clk_hw *hw)
 {
-	struct mstp_clock *clock = to_mod_clock(hw);
+	struct mod_clock *clock = to_mod_clock(hw);
 
 	if (clock->sibling) {
 		struct rzg2l_cpg_priv *priv = clock->priv;
@@ -1509,7 +1509,7 @@ static int rzg2l_mod_clock_enable(struct clk_hw *hw)
 
 static void rzg2l_mod_clock_disable(struct clk_hw *hw)
 {
-	struct mstp_clock *clock = to_mod_clock(hw);
+	struct mod_clock *clock = to_mod_clock(hw);
 
 	if (clock->sibling) {
 		struct rzg2l_cpg_priv *priv = clock->priv;
@@ -1529,7 +1529,7 @@ static void rzg2l_mod_clock_disable(struct clk_hw *hw)
 
 static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 {
-	struct mstp_clock *clock = to_mod_clock(hw);
+	struct mod_clock *clock = to_mod_clock(hw);
 	struct rzg2l_cpg_priv *priv = clock->priv;
 	u32 bitmask = BIT(clock->bit);
 	u32 value;
@@ -1556,11 +1556,11 @@ static const struct clk_ops rzg2l_mod_clock_ops = {
 	.is_enabled = rzg2l_mod_clock_is_enabled,
 };
 
-static struct mstp_clock
-*rzg2l_mod_clock_get_sibling(struct mstp_clock *clock,
+static struct mod_clock
+*rzg2l_mod_clock_get_sibling(struct mod_clock *clock,
 			     struct rzg2l_cpg_priv *priv)
 {
-	struct mstp_clock *clk;
+	struct mod_clock *clk;
 	struct clk_hw *hw;
 
 	for_each_mod_clock(clk, hw, priv) {
@@ -1573,7 +1573,7 @@ static struct mstp_clock
 
 static struct mstop *rzg2l_mod_clock_get_mstop(struct rzg2l_cpg_priv *priv, u32 conf)
 {
-	struct mstp_clock *clk;
+	struct mod_clock *clk;
 	struct clk_hw *hw;
 
 	for_each_mod_clock(clk, hw, priv) {
@@ -1589,7 +1589,7 @@ static struct mstop *rzg2l_mod_clock_get_mstop(struct rzg2l_cpg_priv *priv, u32
 
 static void rzg2l_mod_clock_init_mstop(struct rzg2l_cpg_priv *priv)
 {
-	struct mstp_clock *clk;
+	struct mod_clock *clk;
 	struct clk_hw *hw;
 
 	for_each_mod_clock(clk, hw, priv) {
@@ -1609,9 +1609,9 @@ static void rzg2l_mod_clock_init_mstop(struct rzg2l_cpg_priv *priv)
 }
 
 static int rzg2l_mod_clock_update_shared_mstop_clks(struct rzg2l_cpg_priv *priv,
-						    struct mstp_clock *clock)
+						    struct mod_clock *clock)
 {
-	struct mstp_clock *clk;
+	struct mod_clock *clk;
 	struct clk_hw *hw;
 
 	if (!clock->mstop)
@@ -1619,7 +1619,7 @@ static int rzg2l_mod_clock_update_shared_mstop_clks(struct rzg2l_cpg_priv *priv,
 
 	for_each_mod_clock(clk, hw, priv) {
 		int num_shared_mstop_clks, incr = 1;
-		struct mstp_clock **new_clks;
+		struct mod_clock **new_clks;
 
 		if (clk->mstop != clock->mstop)
 			continue;
@@ -1653,7 +1653,7 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 			   const struct rzg2l_cpg_info *info,
 			   struct rzg2l_cpg_priv *priv)
 {
-	struct mstp_clock *clock = NULL;
+	struct mod_clock *clock = NULL;
 	struct device *dev = priv->dev;
 	unsigned int id = mod->id;
 	struct clk_init_data init;
@@ -1721,7 +1721,7 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 	}
 
 	if (mod->is_coupled) {
-		struct mstp_clock *sibling;
+		struct mod_clock *sibling;
 
 		clock->enabled = rzg2l_mod_clock_is_enabled(&clock->hw);
 		sibling = rzg2l_mod_clock_get_sibling(clock, priv);
-- 
2.43.0


