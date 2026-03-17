Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB5FD874E
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73772.1773747410451649656
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C962MVqG;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540355459so54171155e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747409; x=1774352209; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEd2/9qMj/rTrf4XQ46tcG9n+1BkOmDEXHah4TcScaA=;
        b=C962MVqGSjN/JNz65l8HWtW1sKM7efFgegiEVyGt5eJBhtUmrJ+qTn7Ivrh4Gp5caC
         Gq1crYzyntYzM1V3xdXZUvcxOcoN9Voign5q9PeNioGrsYpNryoFiY5SPHN+cqEvAZUT
         Ub8sYcfgGoZ8A3lKmOF0u/dz1+6d6R6QA/x+ReDccFyo5ubPvdGDh8FPuUjyYI+DVCXb
         mn/6gcSgy349pkIouuk4kOEFzg9p4idngiEypx8zh2UCQjeS4An+fvDu1CSXxawBYui0
         wx+0FOHSUtWfnDoUcVyiIk6WPYSrrf4UUhXPmpnC8TzNZt5SqLQBYtrIqkQ8Aqi0b0xJ
         Bbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747409; x=1774352209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEd2/9qMj/rTrf4XQ46tcG9n+1BkOmDEXHah4TcScaA=;
        b=PimFYefnpUN+fj0qCb0EfegykHR15n7MKVw802q6X5/yAqbtYqrAnj0Vol1pOhyCkI
         1K7ermGITiS4THFzavu2SuI254IpC2O/nvV8XgdKhdvdiD09mXQsNtC+cHP/CRGbk0A0
         x7ilodOmE1eJH6sHPqTECbURaT3TcriOkh6lLLseLmMtGfOK9puWh9FGTwv/R50MHmRt
         wTJO4WLcPYRBeUXqYepLCS9BODF+0l5eC6MhpWGLkX5zoqBpdHGlVr+nBoyZw8dYe55d
         QkJQwC+C4U0k6rNE0f9BEWiZDmvI+1JwlylWfQyX1RVkFAgZ2U7Kpa9OdiVCnrva5dga
         +5+A==
X-Gm-Message-State: AOJu0YyR82PMVF8oh+7xi5/wvWQT0k7JUtKuTo5xmh6JO/tIVPT8Ra9y
	NWHGfQFxdtqgVE9ASOeavefQngHzmPrvOMi4S03LUxMSEOi1rwDJ8vCH5LV5jw==
X-Gm-Gg: ATEYQzxUzEMNMZlDt+l+XB/jogj5G46YX2If0zFd9LyVQy5WHOre2oTF5DvwC1EFK9D
	DMyRipAarXSbvCPysrV3GutxGXhT8bv2z454CJ85izeTcEk3zCYGWi1JbtJnKZ4HwK7l9OH0I00
	FY6axuTp8IZTRNV++EO3hWotEYxru6S3k5MiUeByyIQbVU6lm5GYlMwjzvgkZHOKD4mqUIkg0zH
	vFjdTG2CytzSzagvb3oHEKfnf5P8/5YGHqoym2CY5+iGAVz4oEcde+wS6v7s/h6vSjUByko7a0G
	nM20523e1Scg792/WBaV7yKgN29vuxVsAwb305cD+Awtsu7Az52Gziq4h2xFe+bgk+Ispuo9nok
	WjHkznlhU9B8vgZhEoaIrMHuSFWgfy++Z7u62+Ql8lfKOlJwuWLxHyPDQRU3P/WXAf65uAmzpWi
	n55v2Fiy8OgAId0GfwCPTZQLcOKLWGz1c8tW5TfaE3jzEWQXKF
X-Received: by 2002:a05:600c:154b:b0:485:40ed:2d1 with SMTP id 5b1f17b1804b1-48556706676mr277909255e9.17.1773747408475;
        Tue, 17 Mar 2026 04:36:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/11] usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support
Date: Tue, 17 Mar 2026 11:36:33 +0000
Message-ID: <20260317113643.311192-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22480

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
index acba343aae54..42069c649fe0 100644
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
index 18bee3189d04..6a4f278cd4e6 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -13,10 +13,12 @@
 #include <linux/of_device.h>
 #include <linux/usb/phy.h>
 #include <linux/sys_soc.h>
+#include <linux/reset.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rcar-regs.h"
+#include "xhci-rzg3e-regs.h"
 #include "xhci-rzv2m.h"
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
@@ -83,6 +85,48 @@ static void xhci_rcar_start(struct usb_hcd *hcd)
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
@@ -220,6 +264,14 @@ static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
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
@@ -236,6 +288,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
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


