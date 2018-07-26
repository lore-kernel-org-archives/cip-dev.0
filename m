From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:26 +0100
Subject: [cip-dev] [PATCH 08/42] clk: Allow clocks to be marked as CRITICAL
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Lee Jones <lee.jones@linaro.org>

Critical clocks are those which must not be gated, else undefined
or catastrophic failure would occur.  Here we have chosen to
ensure the prepare/enable counts are correctly incremented, so as
not to confuse users with enabled clocks with no visible users.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/1455225554-13267-2-git-send-email-mturquette at baylibre.com
(cherry picked from commit 32b9b10961860860268961d9aad0c56a73018c37)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/clk.c            | 5 +++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 53c068f..c2718c8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2469,6 +2469,11 @@ static int __clk_init(struct device *dev, struct clk *clk_user)
 	if (core->ops->init)
 		core->ops->init(core->hw);
 
+	if (core->flags & CLK_IS_CRITICAL) {
+		clk_core_prepare(core);
+		clk_core_enable(core);
+	}
+
 	kref_init(&core->ref);
 out:
 	clk_prepare_unlock();
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7cd0171..b79d854 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,7 @@
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
 
 struct clk;
 struct clk_hw;
-- 
2.7.4
