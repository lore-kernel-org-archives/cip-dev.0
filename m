From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:21 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/21] clk: shmobile: Compile
	clk-rcar-gen2.c when using the r8a7744
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch makes sure clk-rcar-gen2,c gets compiled when
CONFIG_ARCH_R8A7744 is selected, similarly to what done by
commit:
7bac4ad3e40f ("CIP: Build essential clock driver for Renesas
RZ/G1 platforms")

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 2412eb9..6badac5 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
 obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7743)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7744)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7745)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A77470)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
-- 
2.7.4
