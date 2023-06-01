Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C2C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34990.1685631875240749930
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816479"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:36 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0F4AA4010DC0;
	Fri,  2 Jun 2023 00:04:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 09/19] usb: gadget: Add support for RZ/V2M USB3DRD driver
Date: Thu,  1 Jun 2023 16:04:00 +0100
Message-Id: <20230601150410.124773-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11739

commit 9cad72dfc5567c66ab0e5a0a2474c5f36c268694 upstream.

The RZ/V2M USB3.1 Gen1 Interface (USB) composed of a USB3.1 Gen1 Dual Role
Device controller (USB3DRD), a USB3.1 Gen1 Host controller (USB3HOST), a
USB3.1 Gen1 Peripheral controller (USB3PERI).

The reset for both host and peri are located in USB3DRD block. The
USB3DRD registers are mapped in the AXI address space of the Peripheral
module.

Add USB3DRD driver to handle reset for both host and peri modules.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230121145853.4792-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Biju: Added module.h in rzv2m_usb3drd.c to fix build issue]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/gadget/udc/Kconfig         |  13 +++
 drivers/usb/gadget/udc/Makefile        |   1 +
 drivers/usb/gadget/udc/renesas_usb3.c  | 102 +++++++++++-------
 drivers/usb/gadget/udc/rzv2m_usb3drd.c | 140 +++++++++++++++++++++++++
 include/linux/usb/rzv2m_usb3drd.h      |  20 ++++
 5 files changed, 239 insertions(+), 37 deletions(-)
 create mode 100644 drivers/usb/gadget/udc/rzv2m_usb3drd.c
 create mode 100644 include/linux/usb/rzv2m_usb3drd.h

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index f28e1bbd5724..dfaf3eeb2e84 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -191,10 +191,23 @@ config USB_RENESAS_USBHS_UDC
 	   dynamically linked module called "renesas_usbhs" and force all
 	   gadget drivers to also be dynamically linked.
 
+config USB_RZV2M_USB3DRD
+	tristate 'Renesas USB3.1 DRD controller'
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	default USB_XHCI_RZV2M
+	default USB_RENESAS_USB3
+	help
+	   Renesas USB3.1 DRD controller is a USB DRD controller
+	   that supports both host and device switching.
+
+	   Say "y" to link the driver statically, or "m" to build a
+	   dynamically linked module called "rzv2m_usb3drd".
+
 config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on EXTCON
+	select USB_RZV2M_USB3DRD if ARCH_R9A09G011
 	select USB_ROLE_SWITCH
 	help
 	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index f5a7ce28aecd..cb8533549f03 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_USB_TEGRA_XUDC)	+= tegra-xudc.o
 obj-$(CONFIG_USB_M66592)	+= m66592-udc.o
 obj-$(CONFIG_USB_R8A66597)	+= r8a66597-udc.o
 obj-$(CONFIG_USB_RENESAS_USB3)	+= renesas_usb3.o
+obj-$(CONFIG_USB_RZV2M_USB3DRD)	+= rzv2m_usb3drd.o
 obj-$(CONFIG_USB_FSL_QE)	+= fsl_qe_udc.o
 obj-$(CONFIG_USB_S3C_HSUDC)	+= s3c-hsudc.o
 obj-$(CONFIG_USB_LPC32XX)	+= lpc32xx_udc.o
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index ff4edd5187e3..8ad76f7dccb7 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -27,6 +27,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/of.h>
 #include <linux/usb/role.h>
+#include <linux/usb/rzv2m_usb3drd.h>
 
 /* register definitions */
 #define USB3_AXI_INT_STA	0x008
@@ -334,7 +335,7 @@ struct renesas_usb3_priv {
 
 struct renesas_usb3 {
 	void __iomem *reg;
-	struct reset_control *drd_rstc;
+	void __iomem *drd_reg;
 	struct reset_control *usbp_rstc;
 
 	struct usb_gadget gadget;
@@ -426,6 +427,46 @@ static void usb3_clear_bit(struct renesas_usb3 *usb3, u32 bits, u32 offs)
 	usb3_write(usb3, val, offs);
 }
 
+static void usb3_drd_write(struct renesas_usb3 *usb3, u32 data, u32 offs)
+{
+	void __iomem *reg;
+
+	if (usb3->is_rzv2m)
+		reg = usb3->drd_reg + offs - USB3_DRD_CON(usb3);
+	else
+		reg = usb3->reg + offs;
+
+	iowrite32(data, reg);
+}
+
+static u32 usb3_drd_read(struct renesas_usb3 *usb3, u32 offs)
+{
+	void __iomem *reg;
+
+	if (usb3->is_rzv2m)
+		reg = usb3->drd_reg + offs - USB3_DRD_CON(usb3);
+	else
+		reg = usb3->reg + offs;
+
+	return ioread32(reg);
+}
+
+static void usb3_drd_set_bit(struct renesas_usb3 *usb3, u32 bits, u32 offs)
+{
+	u32 val = usb3_drd_read(usb3, offs);
+
+	val |= bits;
+	usb3_drd_write(usb3, val, offs);
+}
+
+static void usb3_drd_clear_bit(struct renesas_usb3 *usb3, u32 bits, u32 offs)
+{
+	u32 val = usb3_drd_read(usb3, offs);
+
+	val &= ~bits;
+	usb3_drd_write(usb3, val, offs);
+}
+
 static int usb3_wait(struct renesas_usb3 *usb3, u32 reg, u32 mask,
 		     u32 expected)
 {
@@ -474,7 +515,7 @@ static void usb3_disable_pipe_irq(struct renesas_usb3 *usb3, int num)
 
 static bool usb3_is_host(struct renesas_usb3 *usb3)
 {
-	return !(usb3_read(usb3, USB3_DRD_CON(usb3)) & DRD_CON_PERI_CON);
+	return !(usb3_drd_read(usb3, USB3_DRD_CON(usb3)) & DRD_CON_PERI_CON);
 }
 
 static void usb3_init_axi_bridge(struct renesas_usb3 *usb3)
@@ -683,18 +724,18 @@ static void usb3_set_mode(struct renesas_usb3 *usb3, bool host)
 {
 	if (usb3->is_rzv2m) {
 		if (host) {
-			usb3_set_bit(usb3, DRD_CON_PERI_RST, USB3_DRD_CON(usb3));
-			usb3_clear_bit(usb3, DRD_CON_HOST_RST, USB3_DRD_CON(usb3));
+			usb3_drd_set_bit(usb3, DRD_CON_PERI_RST, USB3_DRD_CON(usb3));
+			usb3_drd_clear_bit(usb3, DRD_CON_HOST_RST, USB3_DRD_CON(usb3));
 		} else {
-			usb3_set_bit(usb3, DRD_CON_HOST_RST, USB3_DRD_CON(usb3));
-			usb3_clear_bit(usb3, DRD_CON_PERI_RST, USB3_DRD_CON(usb3));
+			usb3_drd_set_bit(usb3, DRD_CON_HOST_RST, USB3_DRD_CON(usb3));
+			usb3_drd_clear_bit(usb3, DRD_CON_PERI_RST, USB3_DRD_CON(usb3));
 		}
 	}
 
 	if (host)
-		usb3_clear_bit(usb3, DRD_CON_PERI_CON, USB3_DRD_CON(usb3));
+		usb3_drd_clear_bit(usb3, DRD_CON_PERI_CON, USB3_DRD_CON(usb3));
 	else
-		usb3_set_bit(usb3, DRD_CON_PERI_CON, USB3_DRD_CON(usb3));
+		usb3_drd_set_bit(usb3, DRD_CON_PERI_CON, USB3_DRD_CON(usb3));
 }
 
 static void usb3_set_mode_by_role_sw(struct renesas_usb3 *usb3, bool host)
@@ -710,9 +751,9 @@ static void usb3_set_mode_by_role_sw(struct renesas_usb3 *usb3, bool host)
 static void usb3_vbus_out(struct renesas_usb3 *usb3, bool enable)
 {
 	if (enable)
-		usb3_set_bit(usb3, DRD_CON_VBOUT, USB3_DRD_CON(usb3));
+		usb3_drd_set_bit(usb3, DRD_CON_VBOUT, USB3_DRD_CON(usb3));
 	else
-		usb3_clear_bit(usb3, DRD_CON_VBOUT, USB3_DRD_CON(usb3));
+		usb3_drd_clear_bit(usb3, DRD_CON_VBOUT, USB3_DRD_CON(usb3));
 }
 
 static void usb3_mode_config(struct renesas_usb3 *usb3, bool host, bool a_dev)
@@ -733,7 +774,7 @@ static void usb3_mode_config(struct renesas_usb3 *usb3, bool host, bool a_dev)
 
 static bool usb3_is_a_device(struct renesas_usb3 *usb3)
 {
-	return !(usb3_read(usb3, USB3_USB_OTG_STA(usb3)) & USB_OTG_IDMON(usb3));
+	return !(usb3_drd_read(usb3, USB3_USB_OTG_STA(usb3)) & USB_OTG_IDMON(usb3));
 }
 
 static void usb3_check_id(struct renesas_usb3 *usb3)
@@ -756,8 +797,8 @@ static void renesas_usb3_init_controller(struct renesas_usb3 *usb3)
 	usb3_set_bit(usb3, USB_COM_CON_PN_WDATAIF_NL |
 		     USB_COM_CON_PN_RDATAIF_NL | USB_COM_CON_PN_LSTTR_PP,
 		     USB3_USB_COM_CON);
-	usb3_write(usb3, USB_OTG_IDMON(usb3), USB3_USB_OTG_INT_STA(usb3));
-	usb3_write(usb3, USB_OTG_IDMON(usb3), USB3_USB_OTG_INT_ENA(usb3));
+	usb3_drd_write(usb3, USB_OTG_IDMON(usb3), USB3_USB_OTG_INT_STA(usb3));
+	usb3_drd_write(usb3, USB_OTG_IDMON(usb3), USB3_USB_OTG_INT_ENA(usb3));
 
 	usb3_check_id(usb3);
 	usb3_check_vbus(usb3);
@@ -767,7 +808,7 @@ static void renesas_usb3_stop_controller(struct renesas_usb3 *usb3)
 {
 	usb3_disconnect(usb3);
 	usb3_write(usb3, 0, USB3_P0_INT_ENA);
-	usb3_write(usb3, 0, USB3_USB_OTG_INT_ENA(usb3));
+	usb3_drd_write(usb3, 0, USB3_USB_OTG_INT_ENA(usb3));
 	usb3_write(usb3, 0, USB3_USB_INT_ENA_1);
 	usb3_write(usb3, 0, USB3_USB_INT_ENA_2);
 	usb3_write(usb3, 0, USB3_AXI_INT_ENA);
@@ -2024,11 +2065,11 @@ static void usb3_irq_idmon_change(struct renesas_usb3 *usb3)
 
 static void usb3_irq_otg_int(struct renesas_usb3 *usb3)
 {
-	u32 otg_int_sta = usb3_read(usb3, USB3_USB_OTG_INT_STA(usb3));
+	u32 otg_int_sta = usb3_drd_read(usb3, USB3_USB_OTG_INT_STA(usb3));
 
-	otg_int_sta &= usb3_read(usb3, USB3_USB_OTG_INT_ENA(usb3));
+	otg_int_sta &= usb3_drd_read(usb3, USB3_USB_OTG_INT_ENA(usb3));
 	if (otg_int_sta)
-		usb3_write(usb3, otg_int_sta, USB3_USB_OTG_INT_STA(usb3));
+		usb3_drd_write(usb3, otg_int_sta, USB3_USB_OTG_INT_STA(usb3));
 
 	if (otg_int_sta & USB_OTG_IDMON(usb3))
 		usb3_irq_idmon_change(usb3);
@@ -2601,7 +2642,6 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&usb3->gadget);
 	reset_control_assert(usb3->usbp_rstc);
-	reset_control_assert(usb3->drd_rstc);
 	renesas_usb3_dma_free_prd(usb3, &pdev->dev);
 
 	__renesas_usb3_ep_free_request(usb3->ep0_req);
@@ -2789,7 +2829,7 @@ static struct usb_role_switch_desc renesas_usb3_role_switch_desc = {
 static int renesas_usb3_probe(struct platform_device *pdev)
 {
 	struct renesas_usb3 *usb3;
-	int irq, drd_irq, ret;
+	int irq, ret;
 	const struct renesas_usb3_priv *priv;
 	const struct soc_device_attribute *attr;
 
@@ -2803,12 +2843,6 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	if (priv->is_rzv2m) {
-		drd_irq = platform_get_irq_byname(pdev, "drd");
-		if (drd_irq < 0)
-			return drd_irq;
-	}
-
 	usb3 = devm_kzalloc(&pdev->dev, sizeof(*usb3), GFP_KERNEL);
 	if (!usb3)
 		return -ENOMEM;
@@ -2837,9 +2871,12 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		return ret;
 
 	if (usb3->is_rzv2m) {
-		ret = devm_request_irq(&pdev->dev, drd_irq,
+		struct rzv2m_usb3drd *ddata = dev_get_drvdata(pdev->dev.parent);
+
+		usb3->drd_reg = ddata->reg;
+		ret = devm_request_irq(ddata->dev, ddata->drd_irq,
 				       renesas_usb3_otg_irq, 0,
-				       dev_name(&pdev->dev), usb3);
+				       dev_name(ddata->dev), usb3);
 		if (ret < 0)
 			return ret;
 	}
@@ -2874,21 +2911,13 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		goto err_add_udc;
 	}
 
-	usb3->drd_rstc = devm_reset_control_get_optional_shared(&pdev->dev,
-								"drd_reset");
-	if (IS_ERR(usb3->drd_rstc)) {
-		ret = PTR_ERR(usb3->drd_rstc);
-		goto err_add_udc;
-	}
-
 	usb3->usbp_rstc = devm_reset_control_get_optional_shared(&pdev->dev,
-								 "aresetn_p");
+								 NULL);
 	if (IS_ERR(usb3->usbp_rstc)) {
 		ret = PTR_ERR(usb3->usbp_rstc);
 		goto err_add_udc;
 	}
 
-	reset_control_deassert(usb3->drd_rstc);
 	reset_control_deassert(usb3->usbp_rstc);
 
 	pm_runtime_enable(&pdev->dev);
@@ -2934,7 +2963,6 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 
 err_reset:
 	reset_control_assert(usb3->usbp_rstc);
-	reset_control_assert(usb3->drd_rstc);
 
 err_add_udc:
 	renesas_usb3_dma_free_prd(usb3, &pdev->dev);
diff --git a/drivers/usb/gadget/udc/rzv2m_usb3drd.c b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
new file mode 100644
index 000000000000..52c7b3ca9c45
--- /dev/null
+++ b/drivers/usb/gadget/udc/rzv2m_usb3drd.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2M USB3DRD driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/usb/rzv2m_usb3drd.h>
+
+#define USB_PERI_DRD_CON	0x000
+
+#define USB_PERI_DRD_CON_PERI_RST	BIT(31)
+#define USB_PERI_DRD_CON_HOST_RST	BIT(30)
+#define USB_PERI_DRD_CON_PERI_CON	BIT(24)
+
+static void rzv2m_usb3drd_set_bit(struct rzv2m_usb3drd *usb3, u32 bits,
+				  u32 offs)
+{
+	u32 val = readl(usb3->reg + offs);
+
+	val |= bits;
+	writel(val, usb3->reg + offs);
+}
+
+static void rzv2m_usb3drd_clear_bit(struct rzv2m_usb3drd *usb3, u32 bits,
+				    u32 offs)
+{
+	u32 val = readl(usb3->reg + offs);
+
+	val &= ~bits;
+	writel(val, usb3->reg + offs);
+}
+
+void rzv2m_usb3drd_reset(struct device *dev, bool host)
+{
+	struct rzv2m_usb3drd *usb3 = dev_get_drvdata(dev);
+
+	if (host) {
+		rzv2m_usb3drd_clear_bit(usb3, USB_PERI_DRD_CON_PERI_CON,
+					USB_PERI_DRD_CON);
+		rzv2m_usb3drd_clear_bit(usb3, USB_PERI_DRD_CON_HOST_RST,
+					USB_PERI_DRD_CON);
+		rzv2m_usb3drd_set_bit(usb3, USB_PERI_DRD_CON_PERI_RST,
+				      USB_PERI_DRD_CON);
+	} else {
+		rzv2m_usb3drd_set_bit(usb3, USB_PERI_DRD_CON_PERI_CON,
+				      USB_PERI_DRD_CON);
+		rzv2m_usb3drd_set_bit(usb3, USB_PERI_DRD_CON_HOST_RST,
+				      USB_PERI_DRD_CON);
+		rzv2m_usb3drd_clear_bit(usb3, USB_PERI_DRD_CON_PERI_RST,
+					USB_PERI_DRD_CON);
+	}
+}
+EXPORT_SYMBOL_GPL(rzv2m_usb3drd_reset);
+
+static int rzv2m_usb3drd_remove(struct platform_device *pdev)
+{
+	struct rzv2m_usb3drd *usb3 = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(usb3->dev);
+	pm_runtime_put(usb3->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(usb3->drd_rstc);
+
+	return 0;
+}
+
+static int rzv2m_usb3drd_probe(struct platform_device *pdev)
+{
+	struct rzv2m_usb3drd *usb3;
+	int ret;
+
+	usb3 = devm_kzalloc(&pdev->dev, sizeof(*usb3), GFP_KERNEL);
+	if (!usb3)
+		return -ENOMEM;
+
+	usb3->dev = &pdev->dev;
+
+	usb3->drd_irq = platform_get_irq_byname(pdev, "drd");
+	if (usb3->drd_irq < 0)
+		return usb3->drd_irq;
+
+	usb3->reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(usb3->reg))
+		return PTR_ERR(usb3->reg);
+
+	platform_set_drvdata(pdev, usb3);
+
+	usb3->drd_rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(usb3->drd_rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(usb3->drd_rstc),
+				     "failed to get drd reset");
+
+	reset_control_deassert(usb3->drd_rstc);
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(usb3->dev);
+	if (ret)
+		goto err_rst;
+
+	ret = of_platform_populate(usb3->dev->of_node, NULL, NULL, usb3->dev);
+	if (ret)
+		goto err_pm;
+
+	return 0;
+
+err_pm:
+	pm_runtime_put(usb3->dev);
+
+err_rst:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(usb3->drd_rstc);
+	return ret;
+}
+
+static const struct of_device_id rzv2m_usb3drd_of_match[] = {
+	{ .compatible = "renesas,rzv2m-usb3drd", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_usb3drd_of_match);
+
+static struct platform_driver rzv2m_usb3drd_driver = {
+	.driver = {
+		.name = "rzv2m-usb3drd",
+		.of_match_table = of_match_ptr(rzv2m_usb3drd_of_match),
+	},
+	.probe = rzv2m_usb3drd_probe,
+	.remove = rzv2m_usb3drd_remove,
+};
+module_platform_driver(rzv2m_usb3drd_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M USB3DRD driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rzv2m_usb3drd");
diff --git a/include/linux/usb/rzv2m_usb3drd.h b/include/linux/usb/rzv2m_usb3drd.h
new file mode 100644
index 000000000000..4cc848de229f
--- /dev/null
+++ b/include/linux/usb/rzv2m_usb3drd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RZV2M_USB3DRD_H
+#define __RZV2M_USB3DRD_H
+
+#include <linux/types.h>
+
+struct rzv2m_usb3drd {
+	void __iomem *reg;
+	int drd_irq;
+	struct device *dev;
+	struct reset_control *drd_rstc;
+};
+
+#if IS_ENABLED(CONFIG_USB_RZV2M_USB3DRD)
+void rzv2m_usb3drd_reset(struct device *dev, bool host);
+#else
+static inline void rzv2m_usb3drd_reset(struct device *dev, bool host) { }
+#endif
+
+#endif /* __RZV2M_USB3DRD_H */
-- 
2.25.1


