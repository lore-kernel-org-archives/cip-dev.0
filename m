Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DAE106704F
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24717.1773329728934812302
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UR6mK6aB;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so13338465e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329727; x=1773934527; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7phw4w0zC49fFJpY4zuZ3//Cqu7zfuO/spdLkjTzaA=;
        b=UR6mK6aBdQVC6WhI0ZwARL6UVXqLIcwYJvXrh9g/HhYGp8wsJfLRQYskqylQl8isWy
         j0tBc/r8/EkmaQ/AL4Du9LejEgFo2Am32MwXy8ACzoxofvUK/uAbttIGKtk2QVy0yvAO
         qnHrwiIv9uWYcxquCpVtdUXb+GZb8i/BN89178l8o6NMiNQS6MfeKgVkeO4TUWCiFxx2
         vb5+xzt6wykyXm0HgydlKMnXFpOha2oQXmIye39C5pbcIGSpQMOCf5eBskTno8gMYsR4
         I9GYNbPwyZb/vDf9DqUybNfHcM3xU+I3hAHWO20+yiZizGfhHaF+3XFffw588nh47sFg
         gYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329727; x=1773934527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7phw4w0zC49fFJpY4zuZ3//Cqu7zfuO/spdLkjTzaA=;
        b=cXwn8Mvn5408TxNwoc6AW4FpMi4UNc0jd/6gaHW+DXca6GIY67/ajKWJk/Dqq+xcrR
         LL57V7TuroafiuIpXZlOssav0b2/pm0HbMEItZ6lew3LXe8L/SUgNxleRpkfUVYPjXBF
         fHe/2nLi2S/XXFRbkgkOQxqiM8WD+A4cmC9D9q0/UHadouwSOMNECt94hsQihHc2iqWE
         hYLLFRPLbbAAbE52lTnz4sZmCiNrLwi4FQ+fTfP3WnBENeqUIB6yZUfDuoxK7N9gIGny
         YzJEmhGQmcXfh0VEK79mt/m3IqbDadrw8TVd1dOfhfbuPkBwz14wDW+DzDNlGSFcVHwB
         MQsA==
X-Gm-Message-State: AOJu0Yz7npvEZrIAsmJ8Fsg1hAIXb5RjQIIqbpXC0lvm8k3dOTek4NGv
	/yuCC18ae+DZuCdRSEjBEvtUxXBlFvl1AStFRP35AJTaDMuvxMBQ7pomDtRi/Q==
X-Gm-Gg: ATEYQzwhFBcv9xz+PWAv3Fb68bf8vR3hrAKJ42rfutEhGZw0aVvc6LUp20sVTXoB+wz
	vjWByMcMRrvJ/zMeZ4Aeup4RCdahm3/5icL6FQsl2kP+2BJnmbmMNmBvrKcMGOBz1n6V/PLxVq4
	Fp20x7hUmACQEiyTnj3XpS5GvLMmuOQbsj3a4nRhENClE6JfrAHmoN/5pZ7h2E2owazX07nZ9wN
	W2RLjH2wfgRfcIERA91ZhacStdJoB9Dcw0P27rrgvCNAvkBIreWFcvXUh8wpUux+mbaLG8p1gSs
	Nmv6+Oe7izF4zP8qAbWvemU1f1+GDvclIUHxndbUsBGkh+jVXqrLzOVneSVRoaJx/UGFlUsep0r
	vKmh5P7yYU5edyJYlv6lDV/eQGwWoL9a/pikWrI1GHhaIlXr0fc2MeFhP51XFzVMJkcSgU9qnoh
	yghevblpgZUyACzSvYPmp3bjGPDi4EXA83GiRJKysfKoMrYII=
X-Received: by 2002:a05:600c:3106:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-4854b158125mr140133195e9.32.1773329726761;
        Thu, 12 Mar 2026 08:35:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/11] usb: host: xhci-rcar: Move R-Car reg definitions
Date: Thu, 12 Mar 2026 15:35:09 +0000
Message-ID: <20260312153522.1131675-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22360

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit f7acd12eba05fb9e7dba3222e2aeca5f49d38b3a ]

Move xhci-rcar reg definitions to a header file for the preparation of adding
support for RZ/G3E XHCI that has different register definitions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250916150255.4231-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-rcar-regs.h | 49 +++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rcar.c      | 45 +---------------------------
 2 files changed, 50 insertions(+), 44 deletions(-)
 create mode 100644 drivers/usb/host/xhci-rcar-regs.h

diff --git a/drivers/usb/host/xhci-rcar-regs.h b/drivers/usb/host/xhci-rcar-regs.h
new file mode 100644
index 000000000000..5ecbda858be0
--- /dev/null
+++ b/drivers/usb/host/xhci-rcar-regs.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XHCI_RCAR_H
+#define __XHCI_RCAR_H
+
+/*** Register Offset ***/
+#define RCAR_USB3_AXH_STA	0x104	/* AXI Host Control Status */
+#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
+#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
+#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
+
+#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
+#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
+#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
+#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
+#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
+#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
+
+/*** Register Settings ***/
+/* AXI Host Control Status */
+#define RCAR_USB3_AXH_STA_B3_PLL_ACTIVE		0x00010000
+#define RCAR_USB3_AXH_STA_B2_PLL_ACTIVE		0x00000001
+#define RCAR_USB3_AXH_STA_PLL_ACTIVE_MASK (RCAR_USB3_AXH_STA_B3_PLL_ACTIVE | \
+					   RCAR_USB3_AXH_STA_B2_PLL_ACTIVE)
+
+/* Interrupt Enable */
+#define RCAR_USB3_INT_XHC_ENA	0x00000001
+#define RCAR_USB3_INT_PME_ENA	0x00000002
+#define RCAR_USB3_INT_HSE_ENA	0x00000004
+#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
+				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
+
+/* FW Download Control & Status */
+#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
+#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010
+#define RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100
+
+/* LCLK Select */
+#define RCAR_USB3_LCLK_ENA_VAL	0x01030001
+
+/* USB3.0 Configuration */
+#define RCAR_USB3_CONF1_VAL	0x00030204
+#define RCAR_USB3_CONF2_VAL	0x00030300
+#define RCAR_USB3_CONF3_VAL	0x13802007
+
+/* USB3.0 Polarity */
+#define RCAR_USB3_RX_POL_VAL	BIT(21)
+#define RCAR_USB3_TX_POL_VAL	BIT(4)
+
+#endif /* __XHCI_RCAR_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 8b357647728c..b5099d2e2e65 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -14,6 +14,7 @@
 
 #include "xhci.h"
 #include "xhci-plat.h"
+#include "xhci-rcar-regs.h"
 #include "xhci-rzv2m.h"
 
 #define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
@@ -29,50 +30,6 @@
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V1);
 MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
-/*** Register Offset ***/
-#define RCAR_USB3_AXH_STA	0x104	/* AXI Host Control Status */
-#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
-#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
-#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
-
-#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
-#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
-#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
-#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
-#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
-#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
-
-/*** Register Settings ***/
-/* AXI Host Control Status */
-#define RCAR_USB3_AXH_STA_B3_PLL_ACTIVE		0x00010000
-#define RCAR_USB3_AXH_STA_B2_PLL_ACTIVE		0x00000001
-#define RCAR_USB3_AXH_STA_PLL_ACTIVE_MASK (RCAR_USB3_AXH_STA_B3_PLL_ACTIVE | \
-					   RCAR_USB3_AXH_STA_B2_PLL_ACTIVE)
-
-/* Interrupt Enable */
-#define RCAR_USB3_INT_XHC_ENA	0x00000001
-#define RCAR_USB3_INT_PME_ENA	0x00000002
-#define RCAR_USB3_INT_HSE_ENA	0x00000004
-#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
-				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
-
-/* FW Download Control & Status */
-#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
-#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010
-#define RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100
-
-/* LCLK Select */
-#define RCAR_USB3_LCLK_ENA_VAL	0x01030001
-
-/* USB3.0 Configuration */
-#define RCAR_USB3_CONF1_VAL	0x00030204
-#define RCAR_USB3_CONF2_VAL	0x00030300
-#define RCAR_USB3_CONF3_VAL	0x13802007
-
-/* USB3.0 Polarity */
-#define RCAR_USB3_RX_POL_VAL	BIT(21)
-#define RCAR_USB3_TX_POL_VAL	BIT(4)
-
 static void xhci_rcar_start_gen2(struct usb_hcd *hcd)
 {
 	/* LCLK Select */
-- 
2.43.0


