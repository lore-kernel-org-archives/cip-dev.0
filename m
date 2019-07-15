From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 08/12] phy: renesas: rcar-gen3-usb2:
	follow the hardware manual procedure
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 72c0339c115b31b3c0b22b1809854136cadd49be upstream.

This patch modifies rcar_gen3_init_otg() procedure to follow Figure
73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 16481cfd..685d56c 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -310,16 +310,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	/* Should not use functions of read-modify-write a register */
+	val = readl(usb2_base + USB2_LINECTRL1);
+	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
+	      USB2_LINECTRL1_DMRPD_EN | USB2_LINECTRL1_DM_RPD;
+	writel(val, usb2_base + USB2_LINECTRL1);
+
 	val = readl(usb2_base + USB2_VBCTRL);
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
-	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
-	rcar_gen3_control_otg_irq(ch, 1);
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
-	val = readl(usb2_base + USB2_LINECTRL1);
-	rcar_gen3_set_linectrl(ch, 0, 0);
-	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
-	       usb2_base + USB2_LINECTRL1);
+
+	msleep(20);
+
+	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
+	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
 
 	rcar_gen3_device_recognition(ch);
 }
-- 
2.7.4
