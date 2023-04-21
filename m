Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE2C77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6169.1682061470715228262
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786970"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:12 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B788B41AA88B;
	Fri, 21 Apr 2023 16:18:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 16/33] clk: renesas: rzg2l: Make use of CLK_MON registers optional
Date: Fri, 21 Apr 2023 08:17:12 +0100
Message-Id: <20230421071729.130347-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11289

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 63804400f2a5ababe596b4ec908321d6b54f45aa upstream.

The RZ/V2M SoC doesn't use CLK_MON registers, so make them optional.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-9-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 2 ++
 drivers/clk/renesas/r9a07g044-cpg.c | 4 ++++
 drivers/clk/renesas/rzg2l-cpg.c     | 8 +++++++-
 drivers/clk/renesas/rzg2l-cpg.h     | 3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 53a58034bef4..33c2bd8df2e5 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -315,4 +315,6 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	/* Resets */
 	.resets = r9a07g043_resets,
 	.num_resets = R9A07G043_TSU_PRESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index de1fe6d277dc..b31201c7ca7b 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -366,6 +366,8 @@ const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	/* Resets */
 	.resets = r9a07g044_resets,
 	.num_resets = R9A07G044_TSU_PRESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
 };
 #endif
 
@@ -389,5 +391,7 @@ const struct rzg2l_cpg_info r9a07g054_cpg_info = {
 	/* Resets */
 	.resets = r9a07g044_resets,
 	.num_resets = R9A07G054_STPAI_ARESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
 };
 #endif
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 42c6405d6025..c34577c44519 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -496,6 +496,9 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	if (!enable)
 		return 0;
 
+	if (!priv->info->has_clk_mon_regs)
+		return 0;
+
 	for (i = 1000; i > 0; --i) {
 		if (((readl(priv->base + CLK_MON_R(reg))) & bitmask))
 			break;
@@ -566,7 +569,10 @@ static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 	if (clock->sibling)
 		return clock->enabled;
 
-	value = readl(priv->base + CLK_MON_R(clock->off));
+	if (priv->info->has_clk_mon_regs)
+		value = readl(priv->base + CLK_MON_R(clock->off));
+	else
+		value = readl(priv->base + clock->off);
 
 	return value & bitmask;
 }
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 57c935ecd782..80fc07404246 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -191,6 +191,7 @@ struct rzg2l_reset {
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
+ * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
  */
 struct rzg2l_cpg_info {
 	/* Core Clocks */
@@ -211,6 +212,8 @@ struct rzg2l_cpg_info {
 	/* Critical Module Clocks that should not be disabled */
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
+
+	bool has_clk_mon_regs;
 };
 
 extern const struct rzg2l_cpg_info r9a07g043_cpg_info;
-- 
2.25.1


