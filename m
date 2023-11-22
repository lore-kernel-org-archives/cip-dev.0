Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A65C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:32:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20864.1700663522347675239
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:32:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="183887523"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Nov 2023 23:32:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 216A840071EF;
	Wed, 22 Nov 2023 23:32:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/10] clk: Introduce clk_hw_determine_rate_no_reparent()
Date: Wed, 22 Nov 2023 14:31:51 +0000
Message-Id: <20231122143156.204055-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:32:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13629

From: Stephen Boyd <sboyd@kernel.org>

commit 33b70fbc4f815f0acb327fa506c988ef25cd943d upstream.

Some clock drivers do not want to allow any reparenting on a given
clock, but usually do so by not providing any determine_rate
implementation.

Whenever we call clk_round_rate() or clk_set_rate(), this leads to
clk_core_can_round() returning false and thus the rest of the function
either forwarding the rate request to its current parent if
CLK_SET_RATE_PARENT is set, or just returning the current clock rate.

This behaviour happens implicitly, and as we move forward to making a
determine_rate implementation required for muxes, we need some way to
explicitly opt-in for that behaviour.

Fortunately, this is exactly what the clk_core_determine_rate_no_reparent()
function is doing, so we can simply make it available to drivers.

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
Link: https://lore.kernel.org/r/20221018-clk-range-checks-fixes-v4-4-971d5077e7d2@cerno.tech
| Reported-by: kernel test robot <lkp@intel.com>:
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk.c            |  19 +++++
 drivers/clk/clk_test.c       | 152 +++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   2 +
 3 files changed, 173 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6ec7cade4c0b..50adcf88c3ef 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -772,6 +772,25 @@ int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
 
+/*
+ * clk_hw_determine_rate_no_reparent - clk_ops::determine_rate implementation for a clk that doesn't reparent
+ * @hw: mux type clk to determine rate on
+ * @req: rate request, also used to return preferred frequency
+ *
+ * Helper for finding best parent rate to provide a given frequency.
+ * This can be used directly as a determine_rate callback (e.g. for a
+ * mux), or from a more complex clock that may combine a mux with other
+ * operations.
+ *
+ * Returns: 0 on success, -EERROR value on error
+ */
+int clk_hw_determine_rate_no_reparent(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	return clk_core_determine_rate_no_reparent(hw, req);
+}
+EXPORT_SYMBOL_GPL(clk_hw_determine_rate_no_reparent);
+
 /***        clk api        ***/
 
 static void clk_core_rate_unprotect(struct clk_core *core)
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index f9a5c2964c65..93f15cf9db34 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -141,6 +141,12 @@ static const struct clk_ops clk_multiple_parents_mux_ops = {
 	.determine_rate = __clk_mux_determine_rate_closest,
 };
 
+static const struct clk_ops clk_multiple_parents_no_reparent_mux_ops = {
+	.determine_rate = clk_hw_determine_rate_no_reparent,
+	.get_parent = clk_multiple_parents_mux_get_parent,
+	.set_parent = clk_multiple_parents_mux_set_parent,
+};
+
 static int clk_test_init_with_ops(struct kunit *test, const struct clk_ops *ops)
 {
 	struct clk_dummy_context *ctx;
@@ -2394,10 +2400,156 @@ static struct kunit_suite clk_mux_notifier_test_suite = {
 	.test_cases = clk_mux_notifier_test_cases,
 };
 
+static int
+clk_mux_no_reparent_test_init(struct kunit *test)
+{
+	struct clk_multiple_parent_ctx *ctx;
+	const char *parents[2] = { "parent-0", "parent-1"};
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
+							    &clk_dummy_rate_ops,
+							    0);
+	ctx->parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
+	ret = clk_hw_register(NULL, &ctx->parents_ctx[0].hw);
+	if (ret)
+		return ret;
+
+	ctx->parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
+							    &clk_dummy_rate_ops,
+							    0);
+	ctx->parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
+	ret = clk_hw_register(NULL, &ctx->parents_ctx[1].hw);
+	if (ret)
+		return ret;
+
+	ctx->current_parent = 0;
+	ctx->hw.init = CLK_HW_INIT_PARENTS("test-mux", parents,
+					   &clk_multiple_parents_no_reparent_mux_ops,
+					   0);
+	ret = clk_hw_register(NULL, &ctx->hw);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void
+clk_mux_no_reparent_test_exit(struct kunit *test)
+{
+	struct clk_multiple_parent_ctx *ctx = test->priv;
+
+	clk_hw_unregister(&ctx->hw);
+	clk_hw_unregister(&ctx->parents_ctx[0].hw);
+	clk_hw_unregister(&ctx->parents_ctx[1].hw);
+}
+
+/*
+ * Test that if the we have a mux that cannot change parent and we call
+ * clk_round_rate() on it with a rate that should cause it to change
+ * parent, it won't.
+ */
+static void clk_mux_no_reparent_round_rate(struct kunit *test)
+{
+	struct clk_multiple_parent_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *other_parent, *parent;
+	unsigned long other_parent_rate;
+	unsigned long parent_rate;
+	long rounded_rate;
+
+	parent = clk_get_parent(clk);
+	KUNIT_ASSERT_PTR_NE(test, parent, NULL);
+
+	parent_rate = clk_get_rate(parent);
+	KUNIT_ASSERT_GT(test, parent_rate, 0);
+
+	other_parent = clk_hw_get_clk(&ctx->parents_ctx[1].hw, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other_parent);
+	KUNIT_ASSERT_FALSE(test, clk_is_match(parent, other_parent));
+
+	other_parent_rate = clk_get_rate(other_parent);
+	KUNIT_ASSERT_GT(test, other_parent_rate, 0);
+	clk_put(other_parent);
+
+	rounded_rate = clk_round_rate(clk, other_parent_rate);
+	KUNIT_ASSERT_GT(test, rounded_rate, 0);
+	KUNIT_EXPECT_EQ(test, rounded_rate, parent_rate);
+
+	clk_put(clk);
+}
+
+/*
+ * Test that if the we have a mux that cannot change parent and we call
+ * clk_set_rate() on it with a rate that should cause it to change
+ * parent, it won't.
+ */
+static void clk_mux_no_reparent_set_rate(struct kunit *test)
+{
+	struct clk_multiple_parent_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *other_parent, *parent;
+	unsigned long other_parent_rate;
+	unsigned long parent_rate;
+	unsigned long rate;
+	int ret;
+
+	parent = clk_get_parent(clk);
+	KUNIT_ASSERT_PTR_NE(test, parent, NULL);
+
+	parent_rate = clk_get_rate(parent);
+	KUNIT_ASSERT_GT(test, parent_rate, 0);
+
+	other_parent = clk_hw_get_clk(&ctx->parents_ctx[1].hw, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other_parent);
+	KUNIT_ASSERT_FALSE(test, clk_is_match(parent, other_parent));
+
+	other_parent_rate = clk_get_rate(other_parent);
+	KUNIT_ASSERT_GT(test, other_parent_rate, 0);
+	clk_put(other_parent);
+
+	ret = clk_set_rate(clk, other_parent_rate);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_GT(test, rate, 0);
+	KUNIT_EXPECT_EQ(test, rate, parent_rate);
+
+	clk_put(clk);
+}
+
+static struct kunit_case clk_mux_no_reparent_test_cases[] = {
+	KUNIT_CASE(clk_mux_no_reparent_round_rate),
+	KUNIT_CASE(clk_mux_no_reparent_set_rate),
+	{}
+};
+
+/*
+ * Test suite for a clock mux that isn't allowed to change parent, using
+ * the clk_hw_determine_rate_no_reparent() helper.
+ *
+ * These tests exercise that helper, and the proper selection of
+ * rates and parents.
+ */
+static struct kunit_suite clk_mux_no_reparent_test_suite = {
+	.name = "clk-mux-no-reparent",
+	.init = clk_mux_no_reparent_test_init,
+	.exit = clk_mux_no_reparent_test_exit,
+	.test_cases = clk_mux_no_reparent_test_cases,
+};
+
 kunit_test_suites(
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
 	&clk_multiple_parents_mux_test_suite,
+	&clk_mux_no_reparent_test_suite,
 	&clk_mux_notifier_test_suite,
 	&clk_orphan_transparent_multiple_parent_mux_test_suite,
 	&clk_orphan_transparent_single_parent_test_suite,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index aefb06373720..73298958bf10 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1314,6 +1314,8 @@ int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 int clk_mux_determine_rate_flags(struct clk_hw *hw,
 				 struct clk_rate_request *req,
 				 unsigned long flags);
+int clk_hw_determine_rate_no_reparent(struct clk_hw *hw,
+				      struct clk_rate_request *req);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
-- 
2.25.1


