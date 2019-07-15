From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] phy: renesas: rcar-gen3-usb2:
	add conditions for uses_otg_pins == false
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit a602152c81a2c1c0daeae56d145d558d52a70dae upstream.

If uses_otg_pins is set to false, this driver 1) should disable otg
related interruptions, and 2) should not get ID pin signal, to avoid
unexpected behaviors. So, this patch adds conditions for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 575b3d2..4d5cfe5 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -150,7 +150,7 @@ static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
 	void __iomem *usb2_base = ch->base;
 	u32 val = readl(usb2_base + USB2_OBINTEN);
 
-	if (enable)
+	if (ch->uses_otg_pins && enable)
 		val |= USB2_OBINT_BITS;
 	else
 		val &= ~USB2_OBINT_BITS;
@@ -212,6 +212,9 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 
 static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
 {
+	if (!ch->uses_otg_pins)
+		return (ch->dr_mode == USB_DR_MODE_HOST) ? false : true;
+
 	return !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
 }
 
-- 
2.7.4
