Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1FC61D9C
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:32:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20864.1700663522347675239
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="183887518"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Nov 2023 23:32:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CA411400720A;
	Wed, 22 Nov 2023 23:32:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/10] clk: Move no reparent case into a separate function
Date: Wed, 22 Nov 2023 14:31:50 +0000
Message-Id: <20231122143156.204055-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:32:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13628

From: Stephen Boyd <sboyd@kernel.org>

commit 1b4e99fda73fd030635f378ee059257f6ad0f780 upseam.

We'll need to turn the code in clk_mux_determine_rate_flags() to deal
with CLK_SET_RATE_NO_REPARENT into a helper clock drivers will be able
to use if they don't want to allow reparenting.

Cc: Abel Vesa <abelvesa@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: David Lechner <david@lechnology.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-actions@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-sunxi@lists.linux.dev
Cc: linux-tegra@vger.kernel.org
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: patches@opensource.cirrus.com
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20221018-clk-range-checks-fixes-v4-3-971d5077e7d2@cerno.tech
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk.c | 75 +++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 755df2133800..6ec7cade4c0b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -583,45 +583,58 @@ clk_core_forward_rate_req(struct clk_core *core,
 		req->max_rate = old_req->max_rate;
 }
 
-int clk_mux_determine_rate_flags(struct clk_hw *hw,
-				 struct clk_rate_request *req,
-				 unsigned long flags)
+static int
+clk_core_determine_rate_no_reparent(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
-	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
-	int i, num_parents, ret;
-	unsigned long best = 0;
-
-	/* if NO_REPARENT flag set, pass through to current parent */
-	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
-		parent = core->parent;
-		if (core->flags & CLK_SET_RATE_PARENT) {
-			struct clk_rate_request parent_req;
+	struct clk_core *core = hw->core;
+	struct clk_core *parent = core->parent;
+	unsigned long best;
+	int ret;
 
-			if (!parent) {
-				req->rate = 0;
-				return 0;
-			}
+	if (core->flags & CLK_SET_RATE_PARENT) {
+		struct clk_rate_request parent_req;
 
-			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
+		if (!parent) {
+			req->rate = 0;
+			return 0;
+		}
 
-			trace_clk_rate_request_start(&parent_req);
+		clk_core_forward_rate_req(core, req, parent, &parent_req,
+					  req->rate);
 
-			ret = clk_core_round_rate_nolock(parent, &parent_req);
-			if (ret)
-				return ret;
+		trace_clk_rate_request_start(&parent_req);
 
-			trace_clk_rate_request_done(&parent_req);
+		ret = clk_core_round_rate_nolock(parent, &parent_req);
+		if (ret)
+			return ret;
 
-			best = parent_req.rate;
-		} else if (parent) {
-			best = clk_core_get_rate_nolock(parent);
-		} else {
-			best = clk_core_get_rate_nolock(core);
-		}
+		trace_clk_rate_request_done(&parent_req);
 
-		goto out;
+		best = parent_req.rate;
+	} else if (parent) {
+		best = clk_core_get_rate_nolock(parent);
+	} else {
+		best = clk_core_get_rate_nolock(core);
 	}
 
+	req->rate = best;
+
+	return 0;
+}
+
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags)
+{
+	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
+	int i, num_parents, ret;
+	unsigned long best = 0;
+
+	/* if NO_REPARENT flag set, pass through to current parent */
+	if (core->flags & CLK_SET_RATE_NO_REPARENT)
+		return clk_core_determine_rate_no_reparent(hw, req);
+
 	/* find the parent that can provide the fastest rate <= rate */
 	num_parents = core->num_parents;
 	for (i = 0; i < num_parents; i++) {
@@ -659,9 +672,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 	if (!best_parent)
 		return -EINVAL;
 
-out:
-	if (best_parent)
-		req->best_parent_hw = best_parent->hw;
+	req->best_parent_hw = best_parent->hw;
 	req->best_parent_rate = best;
 	req->rate = best;
 
-- 
2.25.1


