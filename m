From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:29 +0100
Subject: [cip-dev] [PATCH 11/42] clk: renesas: mstp: Make INTC-SYS a
	critical clock
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-12-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

INTC-SYS is the module clock for the GIC.  Accessing the GIC while it is
disabled causes:

    Unhandled fault: asynchronous external abort (0x1211) at 0x00000000

Currently, the GIC-400 driver cannot enable its module clock for several
reasons:
  - It does not use a platform device, so Runtime PM is not an option,
  - gic_of_init() runs before any clocks are registered, so it cannot
    enable the clock explicitly,
  - gic_of_init() cannot return -EPROBE_DEFER, as IRQCHIP_DECLARE()
    doesn't support deferred probing.

Hence we have to keep on relying on the boot loader for enabling the
module clock.

To prevent the module clock from being disabled when the CCF core thinks
it is unused, and thus causing a system lock-up, add a check to the MSTP
clock driver and enable CLK_IS_CRITICAL. This will make sure the module
clock is never disabled.

This is a hard dependency for describing the INTC-SYS clock in DT on
R-Mobile APE6 and R-Car Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
(cherry picked from commit e34084fb9a023d1dd008c989523af5a037f1d692)
(Added rwdt as critical clock)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/shmobile/clk-mstp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 3b09716..6c7c7ed 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -144,6 +144,11 @@ cpg_mstp_clock_register(const char *name, const char *parent_name,
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
 	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	/* INTC-SYS is the module clock of the GIC, and must not be disabled */
+	if (!strcmp(name, "intc-sys") || !strcmp(name, "rwdt")) {
+		pr_debug("MSTP %s setting CLK_IS_CRITICAL\n", name);
+		init.flags |= CLK_IS_CRITICAL;
+	}
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-- 
2.7.4
