From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:27 +0100
Subject: [cip-dev] [PATCH 09/42] clk: WARN_ON about to disable a critical
	clock
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-10-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/1455225554-13267-3-git-send-email-mturquette at baylibre.com
(cherry picked from commit 2e20fbf592621b2c2aeddd82e0fa3dad053cce03)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c2718c8..a5b6a20 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -575,6 +575,9 @@ static void clk_core_unprepare(struct clk_core *core)
 	if (WARN_ON(core->prepare_count == 0))
 		return;
 
+	if (WARN_ON(core->prepare_count == 1 && core->flags & CLK_IS_CRITICAL))
+		return;
+
 	if (--core->prepare_count > 0)
 		return;
 
@@ -680,6 +683,9 @@ static void clk_core_disable(struct clk_core *core)
 	if (WARN_ON(core->enable_count == 0))
 		return;
 
+	if (WARN_ON(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL))
+		return;
+
 	if (--core->enable_count > 0)
 		return;
 
-- 
2.7.4
