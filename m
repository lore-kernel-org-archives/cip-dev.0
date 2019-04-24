From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:30 +0100
Subject: [cip-dev] [PATCH 4.19.y 07/17] Revert "usb: renesas_usbhs: add
	extcon notifier to set mode for non-otg channel"
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 91b20c5a5be0088f9534483276f86230c3a5872f upstream.

This reverts commit 8ada211d0383b72878582bd312b984a9eae62b30.

R-Car D3 can use OTG mode in fact. So, the commit doesn't need anymore.
In other words, like other R-Car Gen3 SoCs, R-Car D3 can change the mode
by using the phy-rcar-gen3-usb2 driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c |  9 ---------
 drivers/usb/renesas_usbhs/common.h |  1 -
 drivers/usb/renesas_usbhs/rcar3.c  | 11 -----------
 3 files changed, 21 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 33088b9..4b5621d 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -681,15 +681,6 @@ static int usbhs_probe(struct platform_device *pdev)
 		break;
 	case USBHS_TYPE_RCAR_GEN3_WITH_PLL:
 		priv->pfunc = usbhs_rcar3_with_pll_ops;
-		if (!IS_ERR_OR_NULL(priv->edev)) {
-			priv->nb.notifier_call = priv->pfunc.notifier;
-			ret = devm_extcon_register_notifier(&pdev->dev,
-							    priv->edev,
-							    EXTCON_USB_HOST,
-							    &priv->nb);
-			if (ret < 0)
-				dev_err(&pdev->dev, "no notifier registered\n");
-		}
 		break;
 	case USBHS_TYPE_RZA1:
 		priv->pfunc = usbhs_rza1_ops;
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index 555b3e78..3777af8 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -257,7 +257,6 @@ struct usbhs_priv {
 	struct platform_device *pdev;
 
 	struct extcon_dev *edev;
-	struct notifier_block nb;
 
 	spinlock_t		lock;
 
diff --git a/drivers/usb/renesas_usbhs/rcar3.c b/drivers/usb/renesas_usbhs/rcar3.c
index d0ea4ff..b9a8453 100644
--- a/drivers/usb/renesas_usbhs/rcar3.c
+++ b/drivers/usb/renesas_usbhs/rcar3.c
@@ -112,16 +112,6 @@ static int usbhs_rcar3_get_id(struct platform_device *pdev)
 	return USBHS_GADGET;
 }
 
-static int usbhs_rcar3_notifier(struct notifier_block *nb, unsigned long event,
-				void *data)
-{
-	struct usbhs_priv *priv = container_of(nb, struct usbhs_priv, nb);
-
-	usbhs_rcar3_set_usbsel(priv, !!event);
-
-	return NOTIFY_DONE;
-}
-
 const struct renesas_usbhs_platform_callback usbhs_rcar3_ops = {
 	.power_ctrl = usbhs_rcar3_power_ctrl,
 	.get_id = usbhs_rcar3_get_id,
@@ -130,5 +120,4 @@ const struct renesas_usbhs_platform_callback usbhs_rcar3_ops = {
 const struct renesas_usbhs_platform_callback usbhs_rcar3_with_pll_ops = {
 	.power_ctrl = usbhs_rcar3_power_and_pll_ctrl,
 	.get_id = usbhs_rcar3_get_id,
-	.notifier = usbhs_rcar3_notifier,
 };
-- 
2.7.4
