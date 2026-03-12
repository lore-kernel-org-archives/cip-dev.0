Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD72C1067054
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24576.1773329730425441583
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Wzjlbt3t;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so13489255e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329728; x=1773934528; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSQiwY5MyoZyjeIW0NP2lQjTXjVZtkdbQ3RbVx+DCdI=;
        b=Wzjlbt3tIWVXjXx/YYuazp1vL6PPKGncbwTrQfWxdidAUzSVwLxCph4BxqxBSBpabY
         uzrRjhmf8Iov9QmgzGbuxOttAtiKMxE2IddklxY/tEYC/L22HADuSoUkLAECiHdBSgVq
         xly+wjmfsZyG9Mh8KJ5WYtMe2S63QSK7VLH7yVwm9nT3MjNRA5+ODz53GNOw1gjUaDNN
         ltv9+sYJ3ijgnxqjyEqNz2axeG0Tm+Wq6udZH7hpTFYENzxls8ApMMevUzXngEvvhcxU
         Fkkuc2hj6hkAVEI5+e4Rf1zXurh2+GZ+YxeZcwXe43qnD3JRrPja8krPmPSFFL58VNOH
         ZK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329728; x=1773934528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XSQiwY5MyoZyjeIW0NP2lQjTXjVZtkdbQ3RbVx+DCdI=;
        b=ZstpwJ3hM/jXXKWHdFjuhbe6RaxLfraUyEF4rg4d7a/J+4GE7V0zqRhIr6ff92nDBf
         DQX9/hTcHk/L/nuYm40CB2oX+IWUeeCb1xb+Uiu/iWI47WcLiFCk4bLrjWHgQDsLEscV
         l+EzvMx5rvJ13tkWEGemxFqbthQhY8CfCYck4Ms3rvkKxnjPk//dfHodLqxr9mmp50NT
         QbtWQsDZBW4GhleGKu95S1kdrfsKH0+W9Ve9I/1uuAgsoZMb9SJSs/r4FVFEa6JiZvIh
         Kj2XSKGL7eygh7M/T/rN8e3l3rQuRM4IUfdMxrxIQ8oLSsqWn2OZ5iqe7TfBWMHu01Xh
         H05Q==
X-Gm-Message-State: AOJu0YzOE9lmFg6AZwkdzxqHgb+RDzk90uV8aWk4YJcpuIkBUYgjXGG1
	jdQmn6SBP95ujwY5mpi3t5rDqcG4GeFuureAHidixBZUiudOo5zbLdxXj3QRPw==
X-Gm-Gg: ATEYQzwEVCv6etF7wvSY5gk6hvBIm7tolZvjqA8OkyeMNCeTwydjlqpbqWDjktowskb
	mPmEAKpULXABIhmWMubc+SPhZex6Da3sT5R/tVL5/FcpVCOQeFyrh2ounpCYa61vDFmcItOFKZC
	c2TbUO11MEdQfT56xNhkUY4JV1mxnagc5imLK82b1QTKAlYUr4GLmOaMUYVLKRv5iqu3Br838y1
	D2tTbMqdtWzMjZweVzTStqBe8kPkkhH7/Osl30wjJxcAV5c+iYnQTLhSxe4ILwkOQO8TOWtVMLD
	lpvdpUIAT6CB9FstpQNzK8KQGqfvvxw0ysXgFQE8oeoGdlrYZjU4X4B0p4BIFQVhan8uR+v/0rE
	Krsfsu7JcBds6on+rzVnii4cadJbMFGOn6mwctnTe/vNZi6AYW5Fi2JAuz/r01LyljO1+aJwcCC
	vMtP9i4tmUjt6rgkJ85yUhC7Mdl5H++r6sjv9Xbl7UaQSUmFo=
X-Received: by 2002:a05:600c:3b9c:b0:485:39d6:e305 with SMTP id 5b1f17b1804b1-4854b13922emr110849745e9.23.1773329728016;
        Thu, 12 Mar 2026 08:35:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/11] usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support
Date: Thu, 12 Mar 2026 15:35:11 +0000
Message-ID: <20260312153522.1131675-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22362

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5db5025d32e5b0b4c13198b5570f33d92ae941d3 ]

The USB3.2 Gen2 Host controller (a.k.a USB3HOST), IP found on the RZ/G3E
SoC is similar to R-Car XHCI, but it doesn't require any firmware.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250916150255.4231-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/Kconfig           |  2 +-
 drivers/usb/host/xhci-rcar.c       | 55 ++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rzg3e-regs.h | 12 +++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-rzg3e-regs.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d011d6c753ed..0169b62ee412 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -93,7 +93,7 @@ config USB_XHCI_RCAR
 	default ARCH_RENESAS
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
-	  found in Renesas R-Car ARM SoCs.
+	  found in Renesas R-Car and RZ/G3E alike ARM SoCs.
 
 config USB_XHCI_RZV2M
 	bool "xHCI support for Renesas RZ/V2M SoC"
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index b5099d2e2e65..87c50f6bca6d 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -11,10 +11,12 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/usb/phy.h>
+#include <linux/reset.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rcar-regs.h"
+#include "xhci-rzg3e-regs.h"
 #include "xhci-rzv2m.h"
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
@@ -67,6 +69,48 @@ static void xhci_rcar_start(struct usb_hcd *hcd)
 	}
 }
 
+static void xhci_rzg3e_start(struct usb_hcd *hcd)
+{
+	u32 int_en;
+
+	if (hcd->regs) {
+		/* Update the controller initial setting */
+		writel(0x03130200, hcd->regs + RZG3E_USB3_HOST_U3P0PIPESC(0));
+		writel(0x00160200, hcd->regs + RZG3E_USB3_HOST_U3P0PIPESC(1));
+		writel(0x03150000, hcd->regs + RZG3E_USB3_HOST_U3P0PIPESC(2));
+		writel(0x03130200, hcd->regs + RZG3E_USB3_HOST_U3P0PIPESC(3));
+		writel(0x00180000, hcd->regs + RZG3E_USB3_HOST_U3P0PIPESC(4));
+
+		/* Interrupt Enable */
+		int_en = readl(hcd->regs + RZG3E_USB3_HOST_INTEN);
+		int_en |= RZG3E_USB3_HOST_INTEN_ENA;
+		writel(int_en, hcd->regs + RZG3E_USB3_HOST_INTEN);
+	}
+}
+
+static int xhci_rzg3e_resume(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	return reset_control_deassert(xhci->reset);
+}
+
+static int xhci_rzg3e_post_resume(struct usb_hcd *hcd)
+{
+	xhci_rzg3e_start(hcd);
+
+	return 0;
+}
+
+static int xhci_rzg3e_suspend(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	reset_control_assert(xhci->reset);
+
+	return 0;
+}
+
 static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 {
 	struct device *dev = hcd->self.controller;
@@ -190,6 +234,14 @@ static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
 	.plat_start = xhci_rzv2m_start,
 };
 
+static const struct xhci_plat_priv xhci_plat_renesas_rzg3e = {
+	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
+	.plat_start = xhci_rzg3e_start,
+	.suspend_quirk = xhci_rzg3e_suspend,
+	.resume_quirk = xhci_rzg3e_resume,
+	.post_resume_quirk = xhci_rzg3e_post_resume,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "renesas,xhci-r8a7790",
@@ -206,6 +258,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,xhci-r8a7796",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "renesas,r9a09g047-xhci",
+		.data = &xhci_plat_renesas_rzg3e,
 	}, {
 		.compatible = "renesas,rcar-gen2-xhci",
 		.data = &xhci_plat_renesas_rcar_gen2,
diff --git a/drivers/usb/host/xhci-rzg3e-regs.h b/drivers/usb/host/xhci-rzg3e-regs.h
new file mode 100644
index 000000000000..7a244a47b882
--- /dev/null
+++ b/drivers/usb/host/xhci-rzg3e-regs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XHCI_RZG3E_H
+#define __XHCI_RZG3E_H
+
+#define RZG3E_USB3_HOST_INTEN		0x1044	/* Interrupt Enable */
+#define RZG3E_USB3_HOST_U3P0PIPESC(x)	(0x10c0 + (x) * 4) /* PIPE Status and Control Register */
+
+#define RZG3E_USB3_HOST_INTEN_XHC	BIT(0)
+#define RZG3E_USB3_HOST_INTEN_HSE	BIT(2)
+#define RZG3E_USB3_HOST_INTEN_ENA	(RZG3E_USB3_HOST_INTEN_XHC | RZG3E_USB3_HOST_INTEN_HSE)
+
+#endif /* __XHCI_RZG3E_H */
-- 
2.43.0


