From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:28 +0100
Subject: [cip-dev] [PATCH 10/42] clk: fix critical clock locking
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

The critical clock handling in __clk_core_init isn't taking the enable lock
before calling clk_core_enable, which in turns triggers the warning in the
lockdep_assert_held call in that function when lockep is enabled.

Add the calls to clk_enable_lock/unlock to make sure it doesn't happen.

Fixes: 32b9b1096186 ("clk: Allow clocks to be marked as CRITICAL")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
(cherry picked from commit ef56b79b66faeeb0dc14213d3cc9e0534a960dee)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/clk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a5b6a20..ef6b7891 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2476,8 +2476,13 @@ static int __clk_init(struct device *dev, struct clk *clk_user)
 		core->ops->init(core->hw);
 
 	if (core->flags & CLK_IS_CRITICAL) {
+		unsigned long flags;
+
 		clk_core_prepare(core);
+
+		flags = clk_enable_lock();
 		clk_core_enable(core);
+		clk_enable_unlock(flags);
 	}
 
 	kref_init(&core->ref);
-- 
2.7.4
