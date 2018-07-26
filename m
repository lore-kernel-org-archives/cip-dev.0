From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:25 +0100
Subject: [cip-dev] [PATCH 07/42] clk: shmobile: rcar-gen2: Init R-Car reset
	IP
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Initialize R-Car reset IP by calling rcar_rst_init.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 636070b..6ab0199 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/soc/renesas/rcar-rst.h>
 
 struct rcar_gen2_cpg {
 	struct clk_onecell_data data;
@@ -442,4 +443,6 @@ void __init rcar_gen2_clocks_init(u32 mode)
 	cpg_mode = mode;
 
 	of_clk_init(NULL);
+
+	rcar_rst_init();
 }
-- 
2.7.4
