From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:15 +0100
Subject: [cip-dev] [PATCH v2 03/52] clk: shmobile: Compile clk-rcar-gen2.c
	when using the r8a77470
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch makes sure clk-rcar-gen2,c gets compiled when
CONFIG_ARCH_R8A77470 is selected, similarly to what done by
commit:
7bac4ad3e40f ("CIP: Build essential clock driver for Renesas RZ/G1 platforms")

Unfortunately there is no commit upstream that we can backport
to achieve this as the architecture of the clock driver has
changed quite dramatically over time, and as such we need this
new patch.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* Changed commit message to explain why we can't backport this
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
