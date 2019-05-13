From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:28 +0100
Subject: [cip-dev] [PATCH 4.4.y 03/52] clk: shmobile: Compile
	clk-rcar-gen2.c when using the r8a77470
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch makes sure clk-rcar-gen2,c gets compiled when
CONFIG_ARCH_R8A77470 is selected, similarly to what done by
commit:
7bac4ad3e40f ("CIP: Build essential clock driver for Renesas RZ/G1 platforms")

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index b339c0b..2412eb9 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7743)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7745)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A77470)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
-- 
2.7.4
