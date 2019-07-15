From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:44 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/12] phy: renesas: rcar-gen3-usb2:
	unify OBINTEN handling
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 7ab0305d4d7725699169e21cdc4f6c8759c32feb upstream.

This patch unifies the OBINTEN handling to clean-up the code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index deb8484..575b3d2 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -145,6 +145,18 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
 	writel(val, usb2_base + USB2_ADPCTRL);
 }
 
+static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
+{
+	void __iomem *usb2_base = ch->base;
+	u32 val = readl(usb2_base + USB2_OBINTEN);
+
+	if (enable)
+		val |= USB2_OBINT_BITS;
+	else
+		val &= ~USB2_OBINT_BITS;
+	writel(val, usb2_base + USB2_OBINTEN);
+}
+
 static void rcar_gen3_init_for_host(struct rcar_gen3_chan *ch)
 {
 	rcar_gen3_set_linectrl(ch, 1, 1);
@@ -190,16 +202,12 @@ static void rcar_gen3_init_for_a_peri(struct rcar_gen3_chan *ch)
 
 static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 {
-	void __iomem *usb2_base = ch->base;
-	u32 val;
-
-	val = readl(usb2_base + USB2_OBINTEN);
-	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 0);
 
 	rcar_gen3_enable_vbus_ctrl(ch, 1);
 	rcar_gen3_init_for_host(ch);
 
-	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 1);
 }
 
 static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
@@ -289,8 +297,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_VBCTRL);
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
 	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
-	val = readl(usb2_base + USB2_OBINTEN);
-	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
+	rcar_gen3_control_otg_irq(ch, 1);
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	val = readl(usb2_base + USB2_LINECTRL1);
-- 
2.7.4
