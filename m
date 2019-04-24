From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:28 +0100
Subject: [cip-dev] [PATCH 4.19.y 05/17] usb: renesas_usbhs: Add reset_control
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit f181dbb4824130e84f46e5be5b49cf6456f96683 upstream.

R-Car Gen3 needs to deassert resets of both host and peripheral.
Since [eo]hci-platform is possible to assert the reset(s) when
the probing failed, renesas_usbhs driver doesn't work correctly
regardless of finished probing. To fix this issue, this patch adds
reset_control on this renesas_usbhs driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 12 ++++++++++++
 drivers/usb/renesas_usbhs/common.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index b079258..0601b14 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include "common.h"
@@ -578,6 +579,10 @@ static int usbhs_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->edev);
 	}
 
+	priv->rsts = devm_reset_control_array_get_optional_shared(&pdev->dev);
+	if (IS_ERR(priv->rsts))
+		return PTR_ERR(priv->rsts);
+
 	/*
 	 * care platform info
 	 */
@@ -662,6 +667,10 @@ static int usbhs_probe(struct platform_device *pdev)
 	/* dev_set_drvdata should be called after usbhs_mod_init */
 	platform_set_drvdata(pdev, priv);
 
+	ret = reset_control_deassert(priv->rsts);
+	if (ret)
+		goto probe_fail_rst;
+
 	/*
 	 * deviece reset here because
 	 * USB device might be used in boot loader.
@@ -715,6 +724,8 @@ static int usbhs_probe(struct platform_device *pdev)
 	return ret;
 
 probe_end_mod_exit:
+	reset_control_assert(priv->rsts);
+probe_fail_rst:
 	usbhs_mod_remove(priv);
 probe_end_fifo_exit:
 	usbhs_fifo_remove(priv);
@@ -743,6 +754,7 @@ static int usbhs_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	usbhs_platform_call(priv, hardware_exit, pdev);
+	reset_control_assert(priv->rsts);
 	usbhs_mod_remove(priv);
 	usbhs_fifo_remove(priv);
 	usbhs_pipe_remove(priv);
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index 6137f79..bce7d35 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -10,6 +10,7 @@
 
 #include <linux/extcon.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/usb/renesas_usbhs.h>
 
 struct usbhs_priv;
@@ -277,6 +278,7 @@ struct usbhs_priv {
 	struct usbhs_fifo_info fifo_info;
 
 	struct phy *phy;
+	struct reset_control *rsts;
 };
 
 /*
-- 
2.7.4
