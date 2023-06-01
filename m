Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E4EC7EE2E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:51 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34581.1685631885156351648
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816493"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:47 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 26DFD4010DC0;
	Fri,  2 Jun 2023 00:04:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 13/19] xhci: host: Add Renesas RZ/V2M SoC support
Date: Thu,  1 Jun 2023 16:04:04 +0100
Message-Id: <20230601150410.124773-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11743

commit c52c9acc415eb6ff54f658492f8c53da0fc3528a upstream.

RZ/V2M is similar to R-Car XHCI but it doesn't require any
firmware, we need to reset the USB Host reset release in DRD Module
before accessing host registers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230121145853.4792-10-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/Kconfig      | 10 +++++++++
 drivers/usb/host/Makefile     |  3 +++
 drivers/usb/host/xhci-plat.c  | 11 ++++++++++
 drivers/usb/host/xhci-rzv2m.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rzv2m.h | 16 +++++++++++++++
 5 files changed, 78 insertions(+)
 create mode 100644 drivers/usb/host/xhci-rzv2m.c
 create mode 100644 drivers/usb/host/xhci-rzv2m.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab12c4bf0ef1..299954c4c0dc 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -54,6 +54,7 @@ config USB_XHCI_PCI_RENESAS
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
 	select USB_XHCI_RCAR if ARCH_RENESAS
+	select USB_XHCI_RZV2M if ARCH_R9A09G011
 	help
 	  Adds an xHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
@@ -95,6 +96,15 @@ config USB_XHCI_RCAR
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas R-Car ARM SoCs.
 
+config USB_XHCI_RZV2M
+	tristate "xHCI support for Renesas RZ/V2M SoC"
+	depends on USB_XHCI_PLATFORM
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	select USB_RZV2M_USB3DRD
+	help
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Renesas RZ/V2M SoC.
+
 config USB_XHCI_TEGRA
 	tristate "xHCI support for NVIDIA Tegra SoCs"
 	depends on PHY_TEGRA_XUSB
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index bc731332fed9..4e34e832e129 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -30,6 +30,9 @@ endif
 ifneq ($(CONFIG_USB_XHCI_RCAR), )
 	xhci-plat-hcd-y		+= xhci-rcar.o
 endif
+ifneq ($(CONFIG_USB_XHCI_RZV2M), )
+	xhci-plat-hcd-y		+= xhci-rzv2m.o
+endif
 
 ifneq ($(CONFIG_DEBUG_FS),)
 	xhci-hcd-y		+= xhci-debugfs.o
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6198a09c1066..a224e7e2f7d5 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -25,6 +25,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-rzv2m.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -134,6 +135,13 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
+	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
+		  XHCI_SLOW_SUSPEND,
+	.init_quirk = xhci_rzv2m_init_quirk,
+	.plat_start = xhci_rzv2m_start,
+};
+
 static const struct xhci_plat_priv xhci_plat_brcm = {
 	.quirks = XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
 };
@@ -173,6 +181,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "renesas,rzv2m-xhci",
+		.data = &xhci_plat_renesas_rzv2m,
 	}, {
 		.compatible = "brcm,xhci-brcm-v2",
 		.data = &xhci_plat_brcm,
diff --git a/drivers/usb/host/xhci-rzv2m.c b/drivers/usb/host/xhci-rzv2m.c
new file mode 100644
index 000000000000..ec65b24eafa8
--- /dev/null
+++ b/drivers/usb/host/xhci-rzv2m.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xHCI host controller driver for RZ/V2M
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/usb/rzv2m_usb3drd.h>
+#include "xhci-plat.h"
+#include "xhci-rzv2m.h"
+
+#define RZV2M_USB3_INTEN	0x1044	/* Interrupt Enable */
+
+#define RZV2M_USB3_INT_XHC_ENA	BIT(0)
+#define RZV2M_USB3_INT_HSE_ENA	BIT(2)
+#define RZV2M_USB3_INT_ENA_VAL	(RZV2M_USB3_INT_XHC_ENA \
+				 | RZV2M_USB3_INT_HSE_ENA)
+
+int xhci_rzv2m_init_quirk(struct usb_hcd *hcd)
+{
+	struct device *dev = hcd->self.controller;
+
+	rzv2m_usb3drd_reset(dev->parent, true);
+
+	return 0;
+}
+
+void xhci_rzv2m_start(struct usb_hcd *hcd)
+{
+	u32 int_en;
+
+	if (hcd->regs) {
+		/* Interrupt Enable */
+		int_en = readl(hcd->regs + RZV2M_USB3_INTEN);
+		int_en |= RZV2M_USB3_INT_ENA_VAL;
+		writel(int_en, hcd->regs + RZV2M_USB3_INTEN);
+	}
+}
diff --git a/drivers/usb/host/xhci-rzv2m.h b/drivers/usb/host/xhci-rzv2m.h
new file mode 100644
index 000000000000..12448b0e8d5b
--- /dev/null
+++ b/drivers/usb/host/xhci-rzv2m.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XHCI_RZV2M_H
+#define __XHCI_RZV2M_H
+
+#if IS_ENABLED(CONFIG_USB_XHCI_RZV2M)
+void xhci_rzv2m_start(struct usb_hcd *hcd);
+int xhci_rzv2m_init_quirk(struct usb_hcd *hcd);
+#else
+static inline void xhci_rzv2m_start(struct usb_hcd *hcd) {}
+static inline int xhci_rzv2m_init_quirk(struct usb_hcd *hcd)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* __XHCI_RZV2M_H */
-- 
2.25.1


